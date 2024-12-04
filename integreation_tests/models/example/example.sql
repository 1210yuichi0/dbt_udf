{{
    config(
        materialized='view',
    )
}}

select {{ ref('f__today') }}() as today, {{ ref('f__multiply') }}(2,3) as product
