CREATE EXTERNAL TABLE `sb_nutrition`(
  `beverage_category` string, 
  `beverage` string, 
  `beverage_prep` string, 
  `calories` bigint, 
  `total_fat_g` decimal(10,2), 
  `trans_fat_g` decimal(10,2), 
  `saturated_fat_g` decimal(10,2), 
  `sodium_mg` decimal(10,2), 
  `total_carbohydrates_g` bigint, 
  `cholesterol_mg` bigint, 
  `dietary_fibre_g` decimal(10,2), 
  `sugars_g` bigint, 
  `protein_g` string, 
  `vitamin_a_perdv` decimal(10,2), 
  `vitamin_c_perdv_#0` decimal(10,2), 
  `calcium__perdv` string, 
  `iron_perdv` decimal(10,2), 
  `caffeine_mg` decimal(10,2))
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://sbhujbal123/curated/'
TBLPROPERTIES (
  'CreatedByJob'='gluejob_sb_nutrition_transform', 
  'CreatedByJobRun'='jr_227551384e083fc88dc20e312b55bd6c2ad0ddc49422006d6950059545e7ef4d', 
  'classification'='parquet', 
  'useGlueParquetWriter'='true')