-- Enable Redshift Spectrum
create external schema spectrum_schema from data catalog
database 'sundb'
iam_role 'arn:aws:iam::783512218838:role/service-role/AmazonRedshift-CommandsAccessRole-20231218T212925'
create external database if not exists;
