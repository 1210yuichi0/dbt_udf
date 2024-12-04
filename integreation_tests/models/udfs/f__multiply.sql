{{
    config(
        materialized='udf',
        schema='udf',
        language='js',
        return_type='FLOAT64',
        arguments=[
            {
                'name': 'x',
                'type': 'FLOAT64',
            },
            {
                'name': 'y',
                'type': 'FLOAT64',
            },
        ],
    )
}}

r"""
  return x*y;
"""
