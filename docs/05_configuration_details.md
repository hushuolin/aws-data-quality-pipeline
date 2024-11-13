# Initial Pipeline Configuration Details

This document provides the configuration details for the initial development of the fintech data quality assurance pipeline. The configurations are designed to align with both the business and project needs, ensuring a functional and minimal setup that can be refined and expanded in the future.

## 1. Amazon S3 Bucket Configuration

### S3 Bucket A (Raw Data Storage)
- **Purpose**: Stores raw transaction data ingested from the KPL producer.
- **Versioning**: Enabled to maintain data integrity by tracking all changes to data.
- **Access Management**:
  - **IAM Policies**:
    - **Software Engineering Team**: Write access to the bucket
    - **Data Engineering Team**: Read and write access to the bucket
  - **Encryption**: Use server-side encryption (SSE-S3) to protect data at rest.

### S3 Bucket C (Logging Storage)
- **Purpose**: Stores logs related to data validation, schema changes, and alerts.
- **Folder Structure**:
  - `/schema-changes/`: Stores logs of schema changes detected by AWS Glue.
  - `/validation-logs/`: Stores logs from data validation processes.
  - `/alerts/`: Stores logs related to alerts triggered during validation or schema changes.
- **Lifecycle Policies**:
  - Archive or delete logs after a defined retention period (e.g., 90 days) to reduce storage costs.
- **Access Management**:
  - **IAM Policies**:
    - **Data Engineering Team**: Read-only access to `/validation-logs/`, `/schema-changes/`, and `/alerts/` folders.
    - **AWS Lambda Functions**: Write access to all folders for logging purposes.
  - **Encryption**: Use server-side encryption (SSE-S3) for logs to ensure data protection.

## 2. AWS Glue Crawler and Data Catalog

### AWS Glue Crawler
- **Purpose**: Crawls data in **S3 Bucket A** to detect schema changes and update the **Glue Data Catalog**.
- **Crawling Frequency**: Scheduled to run daily to ensure up-to-date schema information.
- **Permissions**:
  - **IAM Role**: Configure a role that has read access to **S3 Bucket A** and write permissions to update the **Glue Data Catalog**.

### AWS Glue Data Catalog
- **Purpose**: Stores metadata about the dataset, such as schema details, to facilitate validation.
- **Metadata Updates**: Automatically updated by the Glue Crawler to reflect any changes in the data schema.

## 3. AWS Lambda Configuration

### AWS Lambda for Schema Change Event Handling
- **Purpose**: Processes schema change events detected by **AWS Glue Crawler**.
- **Memory and Timeout Settings**:
  - **Memory**: Set to 512 MB for initial testing. Can be adjusted based on the performance during testing.
  - **Timeout**: Set to 30 seconds to allow sufficient time for processing.
- **Retry Policy**: Configured with an exponential backoff to handle transient failures and ensure fault tolerance.
- **Environment Variables**:
  - Include settings for threshold limits and SNS topic ARN for alerting.

## 4. AWS EventBridge Configuration

### EventBridge Rules
- **Purpose**: Captures schema change events and validation issues, routing them to **AWS Lambda**.
- **Filtering Criteria**: Define rules to capture only significant schema changes and validation errors that require attention.
- **Cross-Account Event Handling**: Not included in the initial configuration but can be added for future scalability.

## 5. AWS SNS (Notification System) Configuration

### SNS Topics for Alerts
- **Purpose**: Sends alerts to data engineers and stakeholders for critical schema changes.
- **Notification Channels**:
  - **Email and SMS**: Configure SNS to send notifications to data engineers via email and SMS to ensure timely response.
- **Subscription Management**:
  - Stakeholders subscribe to topics to receive alerts relevant to their roles.

## 6. Amazon CloudWatch Configuration

### CloudWatch Metrics and Alarms
- **Purpose**: Monitors the performance of AWS Glue, Lambda, and SNS components.
- **Key Metrics**:
  - **Lambda Invocation Errors**: Tracks the number of errors to identify issues in schema event processing.
  - **Glue Crawler Success Rate**: Monitors the successful completion of crawler jobs.
  - **SNS Delivery Status**: Tracks the success rate of notifications.
- **Alarms**:
  - Set alarms for critical metrics, such as Lambda failure rates or Glue job failures, to notify stakeholders via **AWS SNS**.
- **Dashboards**:
  - Create a basic dashboard for consolidated monitoring of key metrics, accessible to the data engineering team.

## Summary
These initial configurations are designed to support the development of a minimal, functional data quality assurance pipeline. The configurations focus on basic data storage, schema detection, event handling, alerting, and monitoring. Once the initial pipeline is tested and validated, additional configurations and enhancements can be added to meet more complex business and operational requirements.

