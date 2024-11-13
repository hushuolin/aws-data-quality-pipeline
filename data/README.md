# Sample Data Documentation

This document provides an overview of the sample datasets generated for testing the fintech data pipeline. Each dataset simulates different scenarios to validate the robustness, scalability, and adaptability of the data pipeline under various conditions.

## Test Matrix

The following matrix summarizes the test scenarios covered by each sample dataset, ensuring comprehensive testing of the pipeline under different real-world conditions.

| Test Scenario               | Dataset File               | Description                                                   | Expected Outcome                                            |
| --------------------------- | -------------------------- | ------------------------------------------------------------- | ----------------------------------------------------------- |
| Baseline Schema             | `1_baseline.csv`           | Tests baseline schema with typical transaction data.          | Data processed correctly without errors.                    |
| New Field Added             | `2_new_field.csv`          | Adds `Location` field to simulate schema update.              | New field handled without errors.                           |
| Missing Field               | `3_missing_field.csv`      | Removes `Transaction-Amount` to simulate missing data.        | Error logged, alert generated for missing field.            |
| Data Type Change            | `4_data_type_change.csv`   | Converts `Transaction-Amount` to string type.                 | Type change detected, handled appropriately.                |
| Empty Dataset               | `5_empty.csv`              | Contains no records, only headers.                            | Warning logged, no processing performed.                    |
| High Volume Dataset         | `6_high_volume.csv`        | Contains 100,000 records to test scalability.                 | Data processed within acceptable performance limits.        |
| Invalid Data Types          | `7_invalid_data.csv`       | Contains `NaN` in `Transaction-Amount`.                       | Error logged, data flagged for review.                      |
| Rapid Schema Changes        | `8_schema_changes.csv`     | Adds `New-Field-1` and `New-Field-2` to simulate frequent changes. | Changes handled with logging and alerts.                |
| Cross-Field Consistency     | `9_cross_field_consistency.csv` | Introduces inconsistency between `Merchant-ID` and `Merchant-Name`. | Inconsistencies flagged, data corrected or logged.     |
| Duplicate Records           | `10_duplicates.csv`        | Introduces duplicates in `Transaction-Reference`.             | Duplicate entries flagged and corrected or removed.         |
| Field Dependency Testing    | `11_field_dependency.csv`  | Tests `Transaction-Amount` impact on `Account-Balance` for debits. | Incorrect balances flagged, corrections applied.        |
| Invalid Transaction Status  | `12_invalid_status.csv`    | Contains invalid values in `Transaction-Status`.              | Invalid status values flagged for review and correction.    |

## Business Scenario

The sample datasets are designed to reflect the data needs of a fintech company that handles digital financial services, such as peer-to-peer payments, digital wallets, and merchant payments. These datasets help validate the system's ability to maintain data integrity, ensure compliance, and handle scalability challenges.

### Key Business Operations
1. **Peer-to-Peer Payments**: Transactions between customers using unique identifiers (`Consumer-ID`, `Profile-ID`). Key fields include `Transaction-Amount`, `Transaction-Type`, and `Transaction-Status`.
2. **Merchant Payments**: Payments for goods and services represented by `Merchant-ID` and `Merchant-Name`. Transactions contain details like `Currency` and `Location`.
3. **Digital Wallet Management**: Users maintain balances (`Account-Balance`) linked to `Account-Number`. Transactions modify these balances, tracked using `Transaction-Reference` and `Timestamp`.

### Challenges Addressed
- **Data Consistency**: The datasets test consistency by simulating scenarios such as missing fields, new fields, data type changes, and cross-field inconsistencies, reflecting real-world challenges during integration or system upgrades.
- **Scalability**: The high-volume dataset (`6_high_volume.csv`) tests the pipeline's ability to handle peak loads efficiently.
- **Error Handling**: Datasets with invalid data types (`7_invalid_data.csv`), empty records (`5_empty.csv`), duplicate entries (`10_duplicates.csv`), and invalid transaction statuses (`12_invalid_status.csv`) validate that the system gracefully handles unexpected scenarios.
- **Field Dependency**: The dataset (`11_field_dependency.csv`) tests the proper handling of dependencies between fields, such as how debit transactions impact `Account-Balance`.

## Sample Datasets Overview

### 1. Baseline Schema (`1_baseline.csv`)
- **Purpose**: Acts as a reference dataset with typical transaction data for comparison.
- **Fields**: `Profile-ID`, `Consumer-ID`, `Customer-Name`, `Session-ID`, `Transaction-Reference`, `Transaction-Amount`, `Currency`, `Transaction-Type`, `Transaction-Status`, `Account-Number`, `Account-Balance`, `Merchant-ID`, `Merchant-Name`, `Fraud-Flag`, `Timestamp`.

### 2. New Field Added (`2_new_field.csv`)
- **Purpose**: Tests the system's ability to handle new fields (`Location`) seamlessly.
- **Fields**: All baseline fields plus `Location`.

### 3. Missing Field (`3_missing_field.csv`)
- **Purpose**: Tests how the pipeline handles missing mandatory fields (`Transaction-Amount`).
- **Fields**: All baseline fields except `Transaction-Amount`.

### 4. Data Type Change (`4_data_type_change.csv`)
- **Purpose**: Verifies robustness when `Transaction-Amount` changes from numeric to string.
- **Fields**: All baseline fields, with `Transaction-Amount` as a string.

### 5. Empty Dataset (`5_empty.csv`)
- **Purpose**: Tests pipeline response to empty datasets with headers only.
- **Fields**: All baseline fields, no data.

### 6. High Volume Dataset (`6_high_volume.csv`)
- **Purpose**: Evaluates performance under heavy load with 100,000 records.
- **Fields**: All baseline fields.

### 7. Invalid Data Types (`7_invalid_data.csv`)
- **Purpose**: Tests system resilience to invalid values (`NaN` in `Transaction-Amount`).
- **Fields**: All baseline fields, with an invalid value in `Transaction-Amount`.

### 8. Rapid Schema Changes (`8_schema_changes.csv`)
- **Purpose**: Tests frequent schema modifications with new fields (`New-Field-1`, `New-Field-2`).
- **Fields**: All baseline fields plus `New-Field-1` and `New-Field-2`.

### 9. Cross-Field Consistency (`9_cross_field_consistency.csv`)
- **Purpose**: Tests the detection and handling of inconsistencies between `Merchant-ID` and `Merchant-Name`.
- **Fields**: All baseline fields, with deliberate cross-field inconsistencies.

### 10. Duplicate Records (`10_duplicates.csv`)
- **Purpose**: Tests the detection and handling of duplicate records in `Transaction-Reference`.
- **Fields**: All baseline fields, with deliberate duplicates.

### 11. Field Dependency Testing (`11_field_dependency.csv`)
- **Purpose**: Tests `Transaction-Amount` impact on `Account-Balance` for debit transactions.
- **Fields**: All baseline fields, with adjustments made to `Account-Balance` based on `Transaction-Amount` for debit transactions.

### 12. Invalid Transaction Status (`12_invalid_status.csv`)
- **Purpose**: Tests handling of invalid values in `Transaction-Status`.
- **Fields**: All baseline fields, with invalid values in `Transaction-Status`.

## Summary
The sample datasets provide a comprehensive basis for testing the fintech data pipeline's ability to maintain data integrity, handle schema changes, and process large volumes effectively. Each dataset targets specific data quality aspects, ensuring the system meets robustness, reliability, and scalability requirements.

For further information, contact the data engineering or quality assurance team.
