#!/bin/bash

set -e

# Variables
TEMPLATE_FILE="cloudformation/eventbridge_rule.yaml"
STACK_NAME="EventBridgeCrossAccount"
TARGET_ACCOUNT_ID="123456789012" # Replace with the target AWS account ID
TARGET_REGION="us-west-2"
TARGET_EVENT_BUS="default"

# Deploy command
aws cloudformation deploy \
  --template-file $TEMPLATE_FILE \
  --stack-name $STACK_NAME \
  --parameter-overrides \
      TargetAccountId=$TARGET_ACCOUNT_ID \
      TargetRegion=$TARGET_REGION \
      TargetEventBus=$TARGET_EVENT_BUS \
  --capabilities CAPABILITY_NAMED_IAM

# Output the status
if [ $? -eq 0 ]; then
  echo "Deployment successful for Cross-Account ${TARGET_ACCOUNT_ID} and Cross-Region ${TARGET_REGION}!"
else
  echo "Deployment failed. Check the CloudFormation events for details."
fi