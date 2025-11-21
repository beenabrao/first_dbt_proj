   {{ config(materialized='table') }}
   
   SELECT c_MktSegment,
    count(c_custkey) as CustomerCount,
    sum(c_AcctBal) as CustAcctBal  
    ---FROM DBT_TestSchema.customers C
    FROM {{ ref('Customer_stg') }} C
    group by c_MktSegment