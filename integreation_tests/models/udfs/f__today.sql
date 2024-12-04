{{
    config(
        materialized='udf',
        schema='udf',
        return_type='DATE',
        arguments=[],
    )
}}

CURRENT_DATE()
