#!/bin/bash

# Shell script to deploy the CloudFormation template for S3 Raw Data Bucket and Data Quality Log Bucket

set -e  # Exit immediately if a command exits with a non-zero status

# Basic configuration
STACK_NAME="SchemaDetectionBucket"
TEMPLATE_FILE="cloudformation/schema_bucket.yaml"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ENVIRONMENT="dev"
REGION="us-east-1"
PROJECT_NAME="fintech-transaction-data-quality-pipeline"

# Create unique bucket name
# Format: resource-project-environment-account-region
SCHEMA_BUCKET_NAME="schema-detection-bucket-${AWS_ACCOUNT_ID}"

# Dry run for template validation
aws cloudformation validate-template \
  --template-body file://$TEMPLATE_FILE || {
  echo "Template validation failed."
  exit 1
}

# Deploy the CloudFormation stack
aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file $TEMPLATE_FILE \
  --parameter-overrides \
    SchemaDetectionBucketName=$SCHEMA_BUCKET_NAME \
    ProjectName=$PROJECT_NAME \
  --capabilities CAPABILITY_NAMED_IAM \
  --region $REGION \
  --tags \
    Project=$PROJECT_NAME \
    Environment=$ENVIRONMENT \
    ManagedBy=CloudFormation

# Output the status of the stack deployment
if [ $? -eq 0 ]; then
  echo "CloudFormation stack '$STACK_NAME' deployed successfully."
  echo "Stack Outputs:"
  aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query "Stacks[0].Outputs" \
    --region $REGION \
    --output table
  
  # Print the full S3 URI for reference
  echo "S3 URI: s3://${SCHEMA_BUCKET_NAME}"
else
  echo "Failed to deploy CloudFormation stack '$STACK_NAME'."
  exit 1
fi