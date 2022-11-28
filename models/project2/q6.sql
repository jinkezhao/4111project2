{{ config(materialized='table') }}

with C as(
    select dst as dst, src as src 
    from dbt_jzhao.q3 
),
B as(
    select dst as dst, src as src 
    from dbt_jzhao.q3 
), 
A as(
    select dst as dst, src as src 
    from dbt_jzhao.q3 
)

select count(*) as no_of_triangles
from A,B,C
where A.dst = B.src and B.dst = C.src and C.dst = A.src and A.dst != B.dst and A.src != B.src and A.dst != C.dst and A.src != C.src


