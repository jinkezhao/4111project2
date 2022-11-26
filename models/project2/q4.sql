{{ config(materialized='table') }}

select g.src,count(*) from dbt_jzhao.q3 as g group by g.src order by count(*) DESC limit 5
select g.dst,count(*) from dbt_jzhao.q3 as g group by g.dst order by count(*) DESC limit  5


