#!/bin/bash

# Description: Script to deploy the Core Infrastructure CloudFormation Stack

set -e  # Exit immediately if a command exits with a non-zero status

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

echo "CloudFormation stack $STACK_NAME deployed successfully."

# Initialize folder structure
echo "Initializing folder structure..."

# Data quality logs bucket folders
FOLDERS=(
  "schema-changes/"
  "validation-logs/"
  "alerts/"
  "raw-data-logs/"
)

# Create folders
for folder in "${FOLDERS[@]}"; do
  echo "Creating folder: ${folder}"
  aws s3api put-object --bucket "${DATA_QUALITY_LOGS_BUCKET_NAME}" --key "${folder}"
done

echo "Folder structure initialization complete."
