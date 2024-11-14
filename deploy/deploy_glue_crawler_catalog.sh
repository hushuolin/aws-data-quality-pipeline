#!/bin/bash

# Script to deploy the AWS Glue Data Crawler and Data Catalog CloudFormation template

set -e  # Exit on error

# Parameters
STACK_NAME="GlueCrawlerAndDataCatalogStack"
TEMPLATE_FILE="cloudformation/glue_crawler_catalog.yml"
RAW_DATA_BUCKET_NAME="raw-transaction-data-bucket"  # Replace with the actual raw data bucket name

# Deploy the CloudFormation stack
aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file $TEMPLATE_FILE \
  --parameter-overrides RawDataBucketName=$RAW_DATA_BUCKET_NAME \
  --capabilities CAPABILITY_NAMED_IAM

# Output stack details
echo "Deployment complete. Outputs:"
aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --query "Stacks[0].Outputs"
