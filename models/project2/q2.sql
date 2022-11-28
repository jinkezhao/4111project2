{{ config(materialized='table') }}

<<<<<<< HEAD
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
=======

with tmp as(
    SELECT FORMAT_DATE('%m',parsed) AS month,FORMAT_DATE('%Y',parsed) AS year 
    From (SELECT PARSE_TIMESTAMP("%a %b %d %T %z %Y", t.create_time) AS parsed, t.text as info from graph.tweets as t)
    where lower(info) like '%maga%'
)


SELECT  CAST(tmp.month as INT64) ,tmp.year,count(*) as count
FROM tmp
group by tmp.month, tmp.year
order by count(*) DESC 
limit 5

>>>>>>> 4c114b6122a7e0b4e2b45e56adeca764fe21e3d9
