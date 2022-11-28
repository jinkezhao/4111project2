{{ config(materialized='table') }}

with C as(
    select dst as dst, src as src 
    from  dbt_jzhao.q3
),
B as(
    select dst as dst, src as src 
    from dbt_jzhao.q3 
), 
A as(
    select dst as dst, src as src 
    from dbt_jzhao.q3
),
node as(
    select distinct A.dst as A, B.dst as B, C.dst as C
	from A,B,C
	where A.dst = B.src and B.dst = C.src and C.dst = A.src 
  
),
count1 as( 
	select count(*) as c1
	from node
	where node.A < node.B and node.B < node.C and node.C > node.A 
),
count2 as( 
	select count(*) as c2
	from node
	where node.A > node.B and node.B > node.C and node.C < node.A 
)
select count1.c1+count2.c2 as no_of_triangles
from count1,count2


