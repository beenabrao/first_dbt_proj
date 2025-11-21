{{ config(materialized='table') }}

WITH CUSTOMERORDER AS (
    SELECT C.c_name as Cust_Name,
    count(o_orderkey) as OrderCount,
    sum(o_totalprice) as OrderAmount dbt 
    ---FROM DBT_TestSchema.customers C
    FROM {{ ref('Customer_stg') }} C
    JOIN {{ ref('Order_Stg') }} Ord 
    ON C.c_custkey =Ord.o_custkey
    GROUP BY C.c_name
    ORDER BY ORDERCOUNT DESC
)

SELECT Cust_Name, OrderAmount, ORDERCOUNT
FROM CUSTOMERORDER