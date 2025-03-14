CREATE DATABASE SCOPED CREDENTIAL cred_adi
WITH
    IDENTITY = 'Managed Identity'

--Create external data source 

CREATE EXTERNAL DATA SOURCE source_silver
WITH(

    LOCATION = 'https://awstoragedatalake25.blob.core.windows.net/silver',
    CREDENTIAL = cred_adi

)

-------

CREATE EXTERNAL DATA SOURCE source_gold
WITH(

    LOCATION = 'https://awstoragedatalake25.blob.core.windows.net/gold',
    CREDENTIAL = cred_adi

)

--creating external file format
-- add data compression as it supports better read performance
CREATE EXTERNAL FILE FORMAT format_parquet
WITH    
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)

-----------------------------------------------------


--CREATE EXTERNAL TABLE EXTSALES
CREATE EXTERNAL TABLE gold.extsales
WITH
(
    LOCATION = 'extsales',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS 
SELECT * FROM gold.sales

SELECT * FROM gold.extsales
