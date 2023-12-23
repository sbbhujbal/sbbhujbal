# Airflow Project for Job orchestration of ELT Data pipeline From Data source file -> S3 bronz layer -> Glue Job - s3 silver layer -> Athena Analytics

!![Airflow ELT Datapipeline Image](images/data_pipeline_airflow_architect_diagram.jpeg)


###  This is really good project to understand Job orchestration in data engineering world using Apache Airflow
### For this project, we are going to  get data from "Keggle" website for "starbucks" nutrition in CSV downloaded on laptop and then upload that data file to AWS S3 bucket. Airflow is gonna upload the data automatically to S3 bucket daily. (I run Airflow in Docker for this project. I used docker compose file to config the container. If you don't know how to run Airflow in Docker, you can read article's on medium.)

### Purpose of this project is to show the AIRFLOW capabilities to run the ELT  workflow orchestration 


## Requirements
- Basic knowledge Airflow
- Basic knowledge Docker
- Intermediate level Python
- Basic knowledge SQL
- Basic knowledge AWS (S3), Glue, Athena

## To do list step by step
1. [Install Docker and Airflow container on your laptop](#)
2. [Create a Glue Job and test it.](#)
3. [Create AWS S3 bucket with 4 folders.](#)
4. [Set Airflow connections for AWS ](#)
5. [Create Airlfow DAG and Task.](#)
6. [Run the DAG.](#)

## Folders in this project source code on Github 
1. dags - This folder contains python dag code - elt_s3_glue.py
2. data - This folder contains CSV file used in this project
3. ddl   - This folder contains DDL to create Glue catalogue table needed for raw and curated zones
4. docker_config - This folder contains docker-compose.yaml file used for local docker AIRFLOW container configuartion in this project.
5. images - This folder contains image of architect diagram of this project - data_pipeline_airflow_architect_diagram.jpeg
6. queries - This folder contains "athena queries for data analysis about starbucks beverages nutrition content"
7. scripts - This folder contains "Glue Jobs TRANSFORM pyspark script" for your reference if needed 

## 1.1. Download "starbucks" nutrition related CSV data file
go to Keggle => https://www.kaggle.com/datasets/henryshan/starbucks
and download CSV file related to starbucks nutrition on your laptop



## 1.2 Install Docker software and get docker-compose file and start Docker, Go to AIRFLOW webserver and test sample DAG

## 2.1 create AWS S3 Bucket
Go to AWS S3 page and create a bucket. My bucket name is 'sbhujbal123'.
Create folders
 1. raw - to ingest strabucks.csv file,
 2. curated - to transform schema and datatypes appropriately and save Glue Jobs output in parquet format,
 3. scripts - to store Glue Jobs scripts,
 4. athena_logs - to store athena query logs 

 ## 2.2 Create IAM role and Glue Jobs
 1. Go to AWS IAM page and create a IAM role for Glue Jobs
 2. Go to AWS Glue catalogue and create database say sundb
 3. Go to AWS Glue studio and create a Visual ETL jOB and create Glue Transform job to change schema ( apply mappinng ) and datatypes
 and ensure input raw data and output curated data - Glue catalogue table is created by this job or used DDL from here to create Table
 4. Run the job with test data and ensure it works.    



 ## 3.2. Create AWS  conneciton
 Open the Airflow webserver → Admin → Connections →Create new connection

- Connection Id: aws_connection (you can change it)
- Connection Type: Amazon Web Services
- AWS Access Key ID: (You can download from AWS account)
- AWS Secret Access Key ID: (You can download from AWS account)

Test it, if there is no problem save it.

## 4. Create Airflow DAG and Task
- This is the python file for DAG and Task. There are only 2 task .
- First task is data ingestion where file gets uploaded into raw zone 
- Second task is a Glue Job which transforms this data and stores into curated folder
```
        from datetime import datetime, timedelta
        from airflow import DAG
        from airflow.providers.amazon.aws.transfers.local_to_s3 import LocalFilesystemToS3Operator
        from airflow.providers.amazon.aws.hooks.glue_catalog import GlueCatalogHook
        from airflow.hooks.S3_hook import S3Hook
        from airflow.operators.python_operator import PythonOperator
        from airflow.providers.amazon.aws.hooks.base_aws import AwsBaseHook
        import boto3

        default_args = {
            'owner': 'airflow',
            'start_date': datetime(2023, 12, 21),
            'retries': 0,
            'retry_delay': timedelta(minutes=5),
        }

        dag = DAG(
            's3_glue_data_pipeline',
            default_args=default_args,
            description='ELT Data Pipeline: Local to S3 to Glue to S3',
            schedule_interval='@daily',
        )
        # Task to run upload file using s3Hook
        def upload_to_s3():
            s3_hook = S3Hook(aws_conn_id='aws_connection')  # Replace with your AWS connection ID
            local_file_path = '/opt/airflow/input/starbucks.csv'  # Replace with your local file path
            s3_bucket_name = 'sbhujbal123'  # Replace with your destination S3 bucket name
            s3_key = 'raw/starbucks.csv'  # Replace with desired S3 key

            s3_hook.load_file(
                filename=local_file_path,
                key=s3_key,
                bucket_name=s3_bucket_name,
                replace=True
            )

        upload_to_s3_task = PythonOperator(
            task_id='upload_to_s3_task',
            python_callable=upload_to_s3,
            dag=dag,
        )

        # Task to run AWS Glue job using GlueJobHook---due to issues with current AIRFLOW version support to Glue Hooks code has been modified to work without AIRFLOW hooks or operator here

        def run_glue_job():
            # Provide AWS credentials explicitly
            aws_access_key_id = 'AKIA3PEKKOL57ZA74MHF'
            aws_secret_access_key = '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'
            aws_region = 'us-east-1'

            client = boto3.client(
                'glue',
                region_name=aws_region,
                aws_access_key_id=aws_access_key_id,
                aws_secret_access_key=aws_secret_access_key
            )

            job_name = 'gluejob_sb_nutrition_transform'  # Replace with your Glue job name
            response = client.start_job_run(JobName=job_name)
            print("Glue job started:", response)

        run_glue_job_task = PythonOperator(
            task_id='run_glue_job_task',
            python_callable=run_glue_job,
            dag=dag,
        )

        # Define task dependencies
        upload_to_s3_task >> run_glue_job_task


```


**##  5. Run the DAG**
- Open and login to Airflow webserver at http://localhost:8080 and the run the DAG manually to test it.

- ALL SUCCESS. Let's check the S3 bucket raw zone, curated zone and Athena Table "sb_nutrition"for data and then do some "Nutrition Analysis" on this data using SQL queries.

**## 6. Athena Analytics**
- Run the code here in queries folder to analyze beverages and nutrion content.
- Check which beverages are healthy and which are not healthy.
- Check beverages by NO calorie , no sugar to High calorie, High sugar etc.


**# That's it. This is the end of this project. Thank you for your interest.**










