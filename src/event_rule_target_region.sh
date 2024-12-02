#!/bin/bash

# Exit immediately if a command exits with a non-zero status
# Also exit on pipe failures and unset variables
set -euo pipefail

# Variables
TEMPLATE_FILE="cloudformation/event_rule_target_region.yaml"
STACK_NAME="TargetRegionEventRule"
REGION="us-west-2" 
CUSTOM_EVENT_BUS_NAME="custom-event-bus"

# Function for error handling
error_handler() {
    echo "Error occurred in script at line: ${1}" >&2
    exit 1
}

# Set up error handling
trap 'error_handler ${LINENO}' ERR

# Get SNS ARN with error checking
echo "Fetching SNS Topic ARN..."
TARGET_SNS_ARN=$(aws cloudformation describe-stacks \
    --stack-name GlueSchemaChangeNotification \
    --region "${REGION}" \
    --query "Stacks[0].Outputs[?ExportName=='GlueSchemaChangeNotification-TopicArn'].OutputValue" \
    --output text) || error_handler ${LINENO}

# Validate SNS ARN
if [[ -z "${TARGET_SNS_ARN}" ]]; then
    echo "Error: Failed to retrieve SNS Topic ARN" >&2
    exit 1
fi

# Validate the CloudFormation template
echo "Validating CloudFormation template..."
aws cloudformation validate-template \
    --template-body "file://${TEMPLATE_FILE}" || error_handler ${LINENO}
echo "Template validation succeeded!"

# Deploy the stack
echo "Deploying CloudFormation stack: ${STACK_NAME}..."
aws cloudformation deploy \
    --template-file "${TEMPLATE_FILE}" \
    --stack-name "${STACK_NAME}" \
    --parameter-overrides \
        "CustomEventBusName=${CUSTOM_EVENT_BUS_NAME}" \
        "TargetSnsArn=${TARGET_SNS_ARN}" \
    --region "${REGION}" \
    --capabilities CAPABILITY_NAMED_IAM || error_handler ${LINENO}

# Output stack details
echo "Deployment complete. Stack details:"
aws cloudformation describe-stacks \
    --stack-name "${STACK_NAME}" \
    --region "${REGION}" \
    --query "Stacks[0].Outputs" \
    --output table || error_handler ${LINENO}
