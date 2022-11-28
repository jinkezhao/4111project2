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
mentioned as(
    select count(*) as cnt
    from popular, unpopular, dbt_jzhao.q3 as m
    where popular.username = m.dst and unpopular.username = m.src
),
unpopular_count as(
    select count(unpopular.username) as cnt
    from unpopular
)
select mentioned.cnt/unpopular_count.cnt as unpopular_popular
from mentioned, unpopular_count