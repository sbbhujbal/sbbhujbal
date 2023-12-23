import json
import base64
import boto3

def lambda_handler(event, context):
    sns = boto3.client('sns')
    
    for record in event["Records"]:
        # Decode the base64-encoded data from the Kinesis record
        payload = json.loads(base64.b64decode(record["kinesis"]["data"]).decode())
        
        # Check if 'systolic pressure' is greater than 160 or 'diastolic pressure' is greater than 100
        if payload.get('systolic', 0) > 160 or payload.get('diastolic', 0) > 100:
            # Construct the message to be sent to the SNS topic
            message = {
                "default": "Notification message", 
                "email": f"Filtered Data: {json.dumps(payload)}"
            }
            
            # Publish message to the specified SNS topic
            sns.publish(
                TopicArn='arn:aws:sns:us-east-1:830193105567:sun_email_notify',
                Message=json.dumps({'default': "Notification message", 'email': message['email']}),
                Subject='Patient Blood Pressure High - Immediate attention needed!',
                MessageStructure='json'
            )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Processed Kinesis events and sent filtered data to SNS')
    }
