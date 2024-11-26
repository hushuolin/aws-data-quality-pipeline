#!/bin/bash

set -e

# Variables
TEMPLATE_FILE="cloudformation/eventbridge_rule.yaml"
STACK_NAME="EventBridgeCrossRegion"
TARGET_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text) # Get current account ID as Target'
TARGET_REGION="us-west-2"
TARGET_EVENT_BUS="default"
LOG_RETENTION_DAYS=30

# Dry run for template validation
aws cloudformation validate-template \
  --template-body file://$TEMPLATE_FILE || {
  echo "Template validation failed."
  exit 1
}

# Deploy command
aws cloudformation deploy \
  --template-file $TEMPLATE_FILE \
  --stack-name $STACK_NAME \
  --parameter-overrides \
      TargetAccountId=$TARGET_ACCOUNT_ID \
      TargetRegion=$TARGET_REGION \
      TargetEventBus=$TARGET_EVENT_BUS \
      LogRetentionInDays=$LOG_RETENTION_DAYS \
  --capabilities CAPABILITY_NAMED_IAM

# Output the status
if [ $? -eq 0 ]; then
  echo "Deployment successful for Same Account ${CURRENT_ACCOUNT_ID}, Cross-Region ${TARGET_REGION}!"
else
  echo "Deployment failed. Check the CloudFormation events for details."
  exit 1
fi