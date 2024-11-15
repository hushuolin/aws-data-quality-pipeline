#!/bin/bash

# Shell script to deploy the CloudFormation template for S3 Raw Data Bucket and Data Quality Log Bucket

set -e  # Exit immediately if a command exits with a non-zero status

STACK_NAME="S3Buckets"
TEMPLATE_FILE="cloudformation/s3_buckets.yaml"
RAW_DATA_BUCKET_NAME="raw-transaction-data-bucket"
DATA_QUALITY_LOGS_BUCKET_NAME="data-quality-logs-bucket"
PROJECT_NAME="DataQualityPipeline"

# Deploy the CloudFormation stack
aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file $TEMPLATE_FILE \
  --parameter-overrides \
    RawDataBucketName=$RAW_DATA_BUCKET_NAME \
    DataQualityLogsBucketName=$DATA_QUALITY_LOGS_BUCKET_NAME \
    ProjectName=$PROJECT_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --region us-east-1

# Output the status of the stack deployment
if [ $? -eq 0 ]; then
  echo "CloudFormation stack '$STACK_NAME' deployed successfully."
else
  echo "Failed to deploy CloudFormation stack '$STACK_NAME'."
  exit 1
fi

