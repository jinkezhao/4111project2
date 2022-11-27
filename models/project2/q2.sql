{{ config(materialized='table') }}

with tmp as (
    SELECT FORMAT_DATE('%b',parsed) AS month,FORMAT_DATE('%Y',parsed) AS year
    From (SELECT PARSE_TIMESTAMP("%a %b %d %T %z %Y", t.create_time) AS parsed, t.text as info from graph.tweets as t)
    where lower(info) like '%maga%'
)
SELECT tmp.month AS month,tmp.year AS year,count(*) as count
From tmp
group by tmp.month,tmp.year
order by count(*) DESC 
limit 5