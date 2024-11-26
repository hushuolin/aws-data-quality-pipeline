#!/bin/bash

set -e

# Variables
TEMPLATE_FILE="cloudformation/custom_event_bus.yaml"
STACK_NAME="CustomEventBusSetup"
EventBus_Name="custom-event-bus"
REGION="us-west-2"

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
        EventBusName=$EventBus_Name\
    --region $REGION

# Output the status of the stack deployment
if [ $? -eq 0 ]; then
  echo "CloudFormation stack '$STACK_NAME' deployed successfully."
else
  echo "Failed to deploy CloudFormation stack '$STACK_NAME'."
  exit 1
fi
