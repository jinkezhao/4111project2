{{ config(materialized='table') }}

with indegree as(
    select dst as username, count(*) as cnt 
    from dbt_jzhao.q3 
    group by dst
),
likes as(
    select twitter_username as username, avg(like_num) as avg_like
    from graph.tweets
    group by twitter_username
), 
popular as(
    select distinct indegree.username
    from indegree, likes
    where indegree.cnt >= (select avg(i.cnt) from indegree as i) and 
        likes.avg_like >= (select avg(t.like_num) from graph.tweets as t) and
        indegree.username = likes.username
),
unpopular as(
    select distinct indegree.username
    from indegree, likes
    where indegree.cnt < (select avg(i.cnt) from indegree as i) and 
        likes.avg_like < (select avg(t.like_num) from graph.tweets as t) and
        indegree.username = likes.username
),
tmp as(
    select * from graph.tweets as t1 where contains_substr(t1.text, '@')
),
popular_mentioned as(
    select count(*) as cnt
    from popular, unpopular, dbt_jzhao.q3 as m, tmp as t
    where unpopular.username = m.src and popular.username = m.dst and m.src = t.twitter_username 
        and m.dst = regexp_extract(split(t.text, '@')[safe_offset(1)], r'^[a-zA-Z0-9_]+')
),
all_tweets as(
    select count(t.twitter_username) as cnt
    from unpopular, graph.tweets as t
    where unpopular.username = t.twitter_username
)
select cast(popular_mentioned.cnt/all_tweets.cnt as FLOAT64) as unpopular_popular
from popular_mentioned, all_tweets
