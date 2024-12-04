#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Variables
TEMPLATE_FILE="cloudformation/sns_sqs_lambda.yaml"
STACK_NAME="GlueSchemaChangeNotification"
REGION="us-west-2"
NOTIFICATION_TOPIC_NAME="GlueSchemaChangeNotifications"
QUEUE_NAME="GlueSchemaChangeQueue"
MESSAGE_RETENTION_PERIOD=1209600  # 14 days in seconds (default)

# Validate the CloudFormation template
echo "Validating CloudFormation template..."
aws cloudformation validate-template \
    --template-body file://$TEMPLATE_FILE
echo "Template validation succeeded!"

# Deploy the stack
echo "Deploying CloudFormation stack: $STACK_NAME..."
aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME \
    --parameter-overrides \
        NotificationTopicName=$NOTIFICATION_TOPIC_NAME \
        QueueName=$QUEUE_NAME \
        MessageRetentionPeriod=$MESSAGE_RETENTION_PERIOD \
    --region $REGION \
    --capabilities CAPABILITY_NAMED_IAM

# Output stack details
echo "Deployment complete. Stack details:"
aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --region $REGION \
    --query "Stacks[0].Outputs" \
    --output table
