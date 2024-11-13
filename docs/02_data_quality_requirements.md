# Data Quality Requirements

This document outlines the data quality requirements for the fintech data pipeline. These requirements are designed to ensure the robustness, reliability, and scalability of the pipeline under various data conditions simulated by the sample datasets.

## 1. Schema Requirements

### Schema Validation
Ensure that all incoming datasets conform to the expected schema to maintain consistency and reliability throughout the data pipeline.

- **Mandatory Fields**: The sample dataset `1_baseline.csv` is used to validate that all required fields are present.
  - Each record must contain the following fields: `Profile-ID`, `Consumer-ID`, `Customer-Name`, `Session-ID`, `Transaction-Reference`, `Transaction-Amount`, `Currency`, `Transaction-Type`, `Transaction-Status`, `Account-Number`, `Account-Balance`, `Merchant-ID`, `Merchant-Name`, `Fraud-Flag`, `Timestamp`.
  - Missing mandatory fields must be logged, and an alert must be generated to notify the data engineering team for immediate remediation.

- **Schema Change Detection**: The sample datasets `2_new_field.csv` and `3_missing_field.csv` are used to test how schema changes, such as added or missing fields, are detected and managed.
  - AWS Glue Crawler should automatically detect schema changes such as new fields or missing fields and update the Glue Table metadata accordingly.
  - Alerts must be generated for critical schema changes, including missing mandatory fields, incorrect data types, and unexpected new fields that could impact downstream processes.
  - Non-critical schema changes (e.g., optional new fields or changes in field order) should be logged for audit purposes without immediate alerts.
  - Any new fields added (e.g., `Location` in `2_new_field.csv`) must be detected, logged, evaluated for downstream impact, and documented for future integration.
  - Missing fields must be flagged, and alerts should be generated if these fields are mandatory.

- **Data Type Validation**: The sample dataset `4_data_type_change.csv` is used to validate changes in data types and ensure they are correctly flagged.
  - Each field must match the expected data type. For instance, `Transaction-Amount` must always be a numerical value (`float`). Any changes in data type (e.g., converting `Transaction-Amount` to string as in `4_data_type_change.csv`) must be flagged, logged, and an alert must be generated for resolution.

## 2. Data Consistency Requirements

### Cross-Field Validation
Ensure data consistency across related fields and maintain the integrity of all records processed by the pipeline.

- **Cross-Field Relationships**: The sample dataset `9_cross_field_consistency.csv` is used to validate relationships between fields and ensure consistency across records.
  - Relationships between fields, such as `Merchant-ID` and `Merchant-Name`, must be consistent across records. Any discrepancies must be flagged and addressed through an automated or manual resolution process.

- **Uniqueness Constraints**: The sample dataset `10_duplicates.csv` is used to test the detection and handling of duplicate `Transaction-Reference` values.
  - Fields like `Transaction-Reference` must be unique within each dataset to prevent duplicate transactions. Duplicate entries must be flagged, logged, and corrected or removed.

- **Field Dependencies**: The sample dataset `11_field_dependency.csv` is used to test `Transaction-Amount` impact on `Account-Balance` for debit transactions.
  - For debit transactions (`Transaction-Type` is `Debit`), ensure that `Transaction-Amount` accurately affects `Account-Balance`.

## 3. Data Validity Requirements

### Business Logic Validation
Ensure all data fields contain valid values that conform to business rules and requirements.

- **Data Type Validity**: The sample dataset `7_invalid_data.csv` is used to validate that invalid data types, such as `NaN` in `Transaction-Amount`, are logged and corrected.
  - Fields like `Transaction-Amount` should not contain invalid values such as `NaN` (as seen in `7_invalid_data.csv`). These values must be logged, and alerts should be triggered for data correction.
  - **Empty Fields**: The sample dataset `5_empty.csv` is used to test how the system handles records with missing mandatory fields. Mandatory fields must not be empty. Any records with empty mandatory fields (e.g., `5_empty.csv`) should be logged with a warning, and an alert should be triggered.

- **Transaction-Specific Rules**: The sample dataset `12_invalid_status.csv` is used to validate that invalid values in `Transaction-Status` are flagged for review.
  - **Transaction Amount**: `Transaction-Amount` must be greater than zero for purchases and should be positive for refunds.
  - **Transaction Status**: The `Transaction-Status` field must have valid values (`Success`, `Failed`, or `Pending`). Any other values should be flagged for review.

## 4. Scalability and Performance Requirements

### High-Volume Data Handling
Ensure that the data pipeline is capable of handling high volumes of data efficiently without performance degradation.

- **Scalability Requirements**: The sample dataset `6_high_volume.csv` is used to test the pipeline's ability to handle large volumes of data without performance degradation.
  - The pipeline should handle datasets of up to 100,000 records without degradation in performance.
  - Processing times for large datasets must meet defined performance benchmarks to ensure scalability during peak loads. These benchmarks should be documented, monitored, and optimized based on historical data processing metrics.

## 5. Error Handling and Notifications

### Error Handling and Notifications
Define how data quality issues are managed and communicated to ensure the reliability and robustness of the system.

- **Error Logging**:
  - All validation errors, warnings, and significant schema changes must be logged for audit and review purposes. This includes validation issues such as missing mandatory fields, incorrect data types, and data inconsistencies.

- **Critical Alerts**:
  - Alerts must be generated for critical issues such as missing mandatory fields, incorrect data types, or duplicate transactions. Alerts should be sent to stakeholders through multiple channels, such as email, SMS, or monitoring dashboards, to ensure timely response.
  - If error thresholds are exceeded (e.g., more than 5% of records contain errors), an escalation process should be triggered to involve relevant stakeholders and ensure prompt resolution.

## Summary
These data quality requirements ensure that the fintech data pipeline can detect schema changes, validate data consistency, and maintain scalability for handling high volumes of transactions. Each team involved, including data engineering and quality assurance, plays a vital role in upholding these standards. The sample datasets comprehensively test these requirements, ensuring that the data pipeline remains robust, reliable, and scalable under various real-world conditions.

