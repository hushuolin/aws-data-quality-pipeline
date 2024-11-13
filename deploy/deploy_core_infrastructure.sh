#!/bin/bash

# Description: Script to deploy the Core Infrastructure CloudFormation Stack

STACK_NAME="CoreInfraStack"
TEMPLATE_FILE="cloudformation/core_infrastructure.yaml"
AWS_REGION="us-east-1"

# Parameters
RAW_DATA_BUCKET_NAME="raw-transaction-data-bucket"
DATA_QUALITY_LOGS_BUCKET_NAME="data-quality-logs-bucket"

# Deploy the CloudFormation stack
aws cloudformation deploy \
  --template-file $TEMPLATE_FILE \
  --stack-name $STACK_NAME \
  --region $AWS_REGION \
  --parameter-overrides RawDataBucketName=$RAW_DATA_BUCKET_NAME DataQualityLogsBucketName=$DATA_QUALITY_LOGS_BUCKET_NAME \
  --capabilities CAPABILITY_NAMED_IAM

# Check deployment status
if [ $? -eq 0 ]; then
  echo "CloudFormation stack $STACK_NAME deployed successfully."
else
  echo "Failed to deploy CloudFormation stack $STACK_NAME."
  exit 1
fi
