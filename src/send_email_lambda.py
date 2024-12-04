import boto3
import json
import os

# Initialize AWS clients
sns_client = boto3.client('sns')

# Environment variable for SNS Topic ARN
SNS_TOPIC_ARN = os.getenv('SNS_TOPIC_ARN')

def lambda_handler(event, context):
    """
    Lambda function to process Glue Data Catalog Table State Change events
    from SQS and send notifications via SNS.
    """
    try:
        # Log the received SQS event
        print("Received event:", json.dumps(event, indent=2))

        # Process each SQS record
        for record in event['Records']:
            # Extract the body of the SQS message (Glue event)
            message_body = record['body']
            glue_event = json.loads(message_body)

            # Validate the Glue event structure
            if 'detail' not in glue_event:
                print("Warning: 'detail' key is missing in the Glue event.")
                continue

            # Extract relevant details from the Glue event
            detail = glue_event['detail']
            database_name = detail.get('databaseName', 'Unknown')
            table_name = detail.get('tableName', 'Unknown')
            type_of_change = detail.get('typeOfChange', 'Unknown')

            # Create a formatted notification message
            message = (
                f"Glue Data Catalog Table State Change Detected:\n"
                f"- Database Name: {database_name}\n"
                f"- Table Name: {table_name}\n"
                f"- Type of Change: {type_of_change}\n"
            )

            # Log the SNS topic ARN and message for debugging
            print(f"Publishing message to SNS Topic ARN: {SNS_TOPIC_ARN}")
            print(f"Message: {message}")

            # Publish the notification to SNS
            response = sns_client.publish(
                TopicArn=SNS_TOPIC_ARN,
                Message=message,
                Subject="Glue Data Catalog Table State Change Notification"
            )

            # Log the SNS response
            print("SNS Publish Response:", response)

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Notifications sent successfully."})
        }

    except Exception as e:
        print("Error processing event:", str(e))
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
