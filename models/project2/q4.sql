{{ config(materialized='table') }}

with outdegree as(
    select g.src as src
    from dbt_jzhao.q3 as g 
    group by g.src 
    order by count(*) DESC 
    limit 1
),
indegree as(
    select g.dst as dst 
    from dbt_jzhao.q3 as g 
    group by g.dst 
    order by count(*) DESC 
    limit  1
)

select indegree.dst as max_indegree, outdegree.src as max_outdegree
from outdegree,indegree



