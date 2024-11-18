#!/bin/bash

# Shell script to deploy the CloudFormation template for Glue Crawler and related resources

set -e  # Exit immediately if a command exits with a non-zero status

# Parameters
STACK_NAME="glue-crawler"
TEMPLATE_FILE="cloudformation/glue_crawler.yaml"
RAW_DATA_BUCKET_NAME="raw-transaction-data-bucket"
GLUE_DATABASE_NAME="fintech_data_catalog"
GLUE_CRAWLER_NAME="FintechDataCrawler"
PROJECT_NAME="DataQualityPipeline"

# Deploy the CloudFormation stack
aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file $TEMPLATE_FILE \
  --parameter-overrides \
    RawDataBucketName=$RAW_DATA_BUCKET_NAME \
    GlueDatabaseName=$GLUE_DATABASE_NAME \
    GlueCrawlerName=$GLUE_CRAWLER_NAME \
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
