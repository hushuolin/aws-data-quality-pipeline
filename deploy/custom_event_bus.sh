#!/bin/bash

set -e

# Variables
TEMPLATE_FILE="cloudformation/custom_event_bus.yaml"
STACK_NAME="CustomEventBusSetup"
EVENT_BUS_NAME="Custom-EventBus"
ACCOUNT_ID="742465305217"
STATEMENT_ID="Custom-EventBus-StatementId"
LOG_NAME="/aws/events/custom-event-bus-loggroup"
EVENT_RULE_NAME="Custom-EventBus-Event-Rule"
GLUE_DATABASE_NAME="fintech_data_catalog"
SNS_TOPIC_NAME="GlueSchemaChangeNotifications"
REGION="us-west-2"

# Deploy command
aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME \
    --parameter-overrides \
        EventBusName=$EVENT_BUS_NAME \
        AccountId=$ACCOUNT_ID \
        StatementId=$STATEMENT_ID \
        LogName=$LOG_NAME \
        EventRuleName=$EVENT_RULE_NAME \
        GlueDatabaseName=$GLUE_DATABASE_NAME \
        SNSTopicName=$SNS_TOPIC_NAME \
    --region $REGION \
    --capabilities CAPABILITY_NAMED_IAM

# Output the status of the stack deployment
if [ $? -eq 0 ]; then
  echo "CloudFormation stack '$STACK_NAME' deployed successfully."
else
  echo "Failed to deploy CloudFormation stack '$STACK_NAME'."
  exit 1
fi
