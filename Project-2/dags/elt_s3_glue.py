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
