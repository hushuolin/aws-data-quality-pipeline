#!/bin/bash

set -e

# Variables
TEMPLATE_FILE="cloudformation/eventbridge_rule.yaml"
STACK_NAME="EventBridgeCrossRegion"
TARGET_REGION="us-west-2"
CURRENT_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text) # Get current account ID
TARGET_EVENT_BUS="default"

# Deploy command
aws cloudformation deploy \
  --template-file $TEMPLATE_FILE \
  --stack-name $STACK_NAME \
  --parameter-overrides \
      TargetAccountId=$CURRENT_ACCOUNT_ID \
      TargetRegion=$TARGET_REGION \
      TargetEventBus=$TARGET_EVENT_BUS \
  --capabilities CAPABILITY_NAMED_IAM

# Output the status
if [ $? -eq 0 ]; then
  echo "Deployment successful for Same Account ${CURRENT_ACCOUNT_ID}, Cross-Region ${TARGET_REGION}!"
else
  echo "Deployment failed. Check the CloudFormation events for details."
fi
