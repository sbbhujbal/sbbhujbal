import json
import boto3
import uuid
import random
import time

def lambda_handler(event, context):
    client = boto3.client('kinesis')
    
    while True:
        data = {
            "id": str(uuid.uuid4()),
            "systolic": random.uniform(100, 300),
            "diastolic": random.uniform(60, 120)
        }
        
        response = client.put_record(
            StreamName="Bloodpressure_iot_stream",
            PartitionKey="Hospital_id",
            Data=json.dumps(data)
        )
    
        print(response)
        
        time.sleep(random.random())