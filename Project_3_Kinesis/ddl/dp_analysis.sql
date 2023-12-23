CREATE EXTERNAL TABLE 'sunsbhujbal123'(
  'id' string COMMENT 'from deserializer', 
  'systolic' double COMMENT 'from deserializer', 
  'diastolic' double COMMENT 'from deserializer')
PARTITIONED BY ( 
  'partition_0' string, 
  'partition_1' string, 
  'partition_2' string, 
  'partition_3' string)
ROW FORMAT SERDE 
  'org.openx.data.jsonserde.JsonSerDe' 
WITH SERDEPROPERTIES ( 
  'paths'='diastolic,id,systolic') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://sbhujbal123/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='sun_crawler_1', 
  'averageRecordSize'='109', 
  'classification'='json', 
  'compressionType'='none', 
  'objectCount'='4', 
  'partition_filtering.enabled'='true', 
  'recordCount'='588', 
  'sizeKey'='64362', 
  'typeOfData'='file')