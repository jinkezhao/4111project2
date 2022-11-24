{{ config(materialized='table') }}

select t.id, t.text from graph.tweets as t where lower(t.text) like '%maga%' and lower(t.text) like '%trump%'