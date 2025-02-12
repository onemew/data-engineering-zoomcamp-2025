# Module 3 Homework: Data Warehouse 

## Preparing for home assignment

Creating external table referring to gcs path:

```sql
CREATE OR REPLACE EXTERNAL TABLE `onemew-project.dezoomcamp_2025_m3_onemew.external_yellow_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://dezoomcamp_2025_m3_onemew/yellow_tripdata_2024-*.parquet']
);
```

Creating materialized table:
```sql
CREATE OR REPLACE TABLE `onemew-project.dezoomcamp_2025_m3_onemew.yellow_tripdata`
```

## Question 1

```sql
SELECT COUNT(1)
FROM `onemew-project.dezoomcamp_2025_m3_onemew.external_yellow_tripdata`
```
Result: 20,332,093

 
## Question 2

```sql
SELECT COUNT(DISTINCT PULocationID) 
FROM `onemew-project.dezoomcamp_2025_m3_onemew.external_yellow_tripdata`

SELECT COUNT(DISTINCT PULocationID) 
FROM `onemew-project.dezoomcamp_2025_m3_onemew.yellow_tripdata`
```
Answer: estimated amount is 0 MB for the External Table and 155.12 MB for the Materialized Table

## Question 3 

```sql
SELECT PULocationID 
FROM `onemew-project.dezoomcamp_2025_m3_onemew.yellow_tripdata`

SELECT PULocationID, DOLocationID 
FROM `onemew-project.dezoomcamp_2025_m3_onemew.yellow_tripdata`
```
Answer: BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed. 

## Question 4

```sql
SELECT COUNT(1)
FROM `onemew-project.dezoomcamp_2025_m3_onemew.yellow_tripdata`
WHERE fare_amount = 0;
```

Answer: 8333

## Question 5

```sql
CREATE OR REPLACE TABLE `finance-automation-389619.dezoomcamp_hw3_2025_onemew.opimized_yellow_tripdata`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM `finance-automation-389619.dezoomcamp_hw3_2025_onemew.yellow_tripdata`;

```

Answer: Partition by tpep_dropoff_datetime and Cluster on VendorID

## Question 6

```sql
SELECT DISTINCT VendorID
FROM `finance-automation-389619.dezoomcamp_hw3_2025_onemew.opimized_yellow_tripdata`
WHERE TIMESTAMP_TRUNC(tpep_dropoff_datetime, DAY) BETWEEN '2024-03-01' AND '2024-03-15'
;
```

Answer: 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table

## Question 7

Answer: GCP Bucket

## Question 8 

Answer: False
 
## Question 9

Answer: This query will process 0 B when run. Because materialized tables have metadata with count of logic records. 

