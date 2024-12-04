{% macro get_create_or_replace_udf_as_sql(relation, compiled_code) -%}
  {{ adapter.dispatch('get_create_or_replace_udf_as_sql', 'dbt_udf')(relation, compiled_code) }}
{%- endmacro %}

{% macro default__get_create_or_replace_udf_as_sql(relation, compiled_code) -%}
    {{ exceptions.raise_compiler_error(
        "`get_create_or_replace_udf_as_sql` has not been implemented for this adapter."
    ) }}
{% endmacro %}

{% macro bigquery__get_create_or_replace_udf_as_sql(relation, compiled_code) -%}
    {%- set arguments = config.get('arguments', []) -%}
    {%- set language = config.get('language', None)  -%}
    CREATE OR REPLACE FUNCTION {{ relation }}(
        {%- for arg in arguments -%}
            {{ arg.name }} {{ arg.type }}{% if not loop.last %}, {% endif %}
        {%- endfor -%}
    )
    RETURNS {{ config.get('return_type', 'STRING') }}
    {%- if language | lower == 'js' %}
    LANGUAGE js
    AS {{ compiled_code }};
    {%- else %}
    AS (
        {{ compiled_code }}
    );
    {%- endif %}

{% endmacro %}

