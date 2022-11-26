{{ config(materialized='table') }}

SELECT FORMAT_DATE('%b',parsed) AS month,FORMAT_DATE('%Y',parsed) AS year,count(*) as count
From (SELECT PARSE_TIMESTAMP("%a %b %d %T %z %Y", t.create_time) AS parsed from graph.tweets as t), graph.tweets as t
where lower(t.text) like '%maga%' 
group by parsed
order by count(*) DESC 
limit 5