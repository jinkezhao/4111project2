{{ config(materialized='table') }}

with tmp as (
select distinct t.twitter_username as src, regexp_extract(split(t.text, '@')[safe_offset(1)], r'^[a-zA-Z0-9_]+') as dst
from graph.tweets as t 
where contains_substr(t.text, '@')
)
select src, dst from tmp where src is not null and dst is not null
