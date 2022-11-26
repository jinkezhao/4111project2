{{ config(materialized='table') }}

with A as(
    select dst as dst, src as src 
    from dbt_jzhao.q3 
),
B as(
    select dst as dst, src as src 
    from dbt_jzhao.q3 
), 
C as(
    select dst as dst, src as src 
    from dbt_jzhao.q3 
)
select count(*) as no_of_triangles
from A,B,C
where A.dst = B.src and B.dst = C.src and C.dst = A.src