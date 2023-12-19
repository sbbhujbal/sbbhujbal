CREATE EXTERNAL TABLE `polluted_countries`(
  `pollution_2023` bigint, 
  `pollution_growth_rate` double, 
  `country_name` string, 
  `ccn3` bigint, 
  `country_region` string, 
  `country_land_area_in_km` double, 
  `pollution_density_in_km` double, 
  `pollution_density_per_mile` double, 
  `pollution_rank` bigint, 
  `mostpollutedcountries_particlepollution` double)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://sbhujbal123/curated/'
TBLPROPERTIES (
  'CreatedByJob'='polluted_countries_etl', 
  'CreatedByJobRun'='jr_94176358e748cf6b709b0dc2a4c2e36239be5a298c24630b709d78c0f8a56532', 
  'classification'='parquet', 
  'useGlueParquetWriter'='true')




