# Sample Data Documentation

This document provides an overview of the sample datasets generated for testing purposes. Each dataset simulates different data scenarios that may occur in a fintech data pipeline. The goal is to validate the robustness, scalability, and adaptability of the data pipeline under a variety of realistic conditions.

## Test Matrix

The following test matrix provides an overview of the testing scenarios covered by each sample dataset. This matrix helps ensure comprehensive testing of the data pipeline under different real-world conditions.

| Test Scenario           | Dataset File            | Description                                                   | Expected Outcome                                            |
| ----------------------- | ----------------------- | ------------------------------------------------------------- | ----------------------------------------------------------- |
| Baseline Schema         | `1_baseline.csv`        | Tests the baseline schema with typical transaction data.      | Data processed correctly with no errors.                    |
| New Field Added         | `2_new_field.csv`       | Adds `Location` field to simulate schema update.              | New field handled without errors.                           |
| Missing Field           | `3_missing_field.csv`   | Removes `Transaction-Amount` to simulate missing data.        | Error logged, and alert sent for missing field.             |
| Data Type Change        | `4_data_type_change.csv`| Converts `Transaction-Amount` to string type.                 | Type change detected, and appropriate handling applied.     |
| Empty Dataset           | `5_empty.csv`           | Contains no records, only headers.                            | No processing, warning logged.                              |
| Invalid Data Types      | `7_invalid_data.csv`    | Contains `NaN` in `Transaction-Amount`.                       | Error logged, and data flagged for review.                  |
| High Volume Dataset     | `6_high_volume.csv`     | Contains 100,000 records to test scalability.                 | Data processed within acceptable performance limits.        |
| Rapid Schema Changes    | `8_schema_changes.csv`  | Adds `New-Field-1` and `New-Field-2` to simulate frequent changes. | Changes handled, with proper logging and alerts.        |
| Cross-Field Consistency | `9_cross_field_consistency.csv` | Ensures consistency between `Merchant-ID` and `Merchant-Name`. | Cross-field consistency validated without errors.           |

## Business Scenario

The sample datasets are designed to reflect the data needs of a typical fintech company that provides digital financial services, such as peer-to-peer payments, digital wallets, and merchant payments. The company processes a large volume of transactions and needs to ensure data integrity, compliance, and scalability.

### Key Business Operations
1. **Peer-to-Peer (P2P) Payments**: Customers can send and receive money instantly using unique identifiers (`Consumer-ID`, `Profile-ID`). These transactions are reflected in fields like `Transaction-Amount`, `Transaction-Type`, and `Transaction-Status`.

2. **Merchant Payments**: Users can pay for products and services from different merchants, represented by `Merchant-ID` and `Merchant-Name`. Transactions also contain details such as `Currency` and `Location`.

3. **Digital Wallet Management**: Users maintain digital wallets, and their balance is represented by `Account-Balance`. Transactions that modify these balances are logged with details like `Account-Number`, `Transaction-Reference`, and `Timestamp`.

### Challenges Addressed by the Sample Data
- **Data Consistency**: The datasets test different aspects of data consistency, such as missing fields, new fields, and data type changes. This helps simulate real-world challenges where data inconsistencies might occur during system integration or upgrades.
- **Scalability**: The high-volume dataset (`6_high_volume.csv`) helps test the scalability of the data pipeline when processing a large number of transactions, ensuring that the system can handle peak loads.
- **Compliance and Robustness**: The datasets with invalid data types (`7_invalid_data.csv`) and empty records (`5_empty.csv`) help validate that the system can handle unexpected scenarios gracefully, which is crucial for regulatory compliance and customer trust.

## Sample Datasets Overview

### 1. Baseline Schema (`1_baseline.csv`)
- **Description**: Contains the baseline schema with typical transaction data.
- **Purpose**: Acts as the reference dataset for comparison against other modified datasets.
- **Fields**: `Profile-ID`, `Consumer-ID`, `Customer-Name`, `Session-ID`, `Transaction-Reference`, `Transaction-Amount`, `Currency`, `Transaction-Type`, `Transaction-Status`, `Account-Number`, `Account-Balance`, `Merchant-ID`, `Merchant-Name`, `Fraud-Flag`, `Timestamp`.

### 2. New Field Added (`2_new_field.csv`)
- **Description**: Adds a new `Location` field to simulate schema updates.
- **Purpose**: To test the pipeline's ability to handle new fields without causing errors.
- **Fields**: All baseline fields plus `Location`.

### 3. Missing Field (`3_missing_field.csv`)
- **Description**: Removes the `Transaction-Amount` field to simulate a scenario where a critical field is missing.
- **Purpose**: To test how the system handles missing mandatory fields and if appropriate alerts are raised.
- **Fields**: All baseline fields except `Transaction-Amount`.

### 4. Data Type Change (`4_data_type_change.csv`)
- **Description**: Converts the `Transaction-Amount` field to a string data type.
- **Purpose**: To verify the system's robustness when data types change unexpectedly.
- **Fields**: All baseline fields, with `Transaction-Amount` as a string.

### 5. Empty Dataset (`5_empty.csv`)
- **Description**: Contains no records but retains the column headers.
- **Purpose**: To test the pipeline’s behavior when an empty dataset is provided, ensuring that the system does not fail unexpectedly.
- **Fields**: All baseline fields, but no data.

### 6. Invalid Data Types (`7_invalid_data.csv`)
- **Description**: Contains an invalid value (`NaN`) in the `Transaction-Amount` field to simulate data corruption or entry errors.
- **Purpose**: To assess the system’s resilience to data quality issues and ensure proper error handling and alerts.
- **Fields**: All baseline fields, with `Transaction-Amount` containing an invalid value.

### 7. High Volume Dataset (`6_high_volume.csv`)
- **Description**: Contains 100,000 records to simulate high-volume transaction data.
- **Purpose**: To evaluate the performance and scalability of the data pipeline under heavy data load.
- **Fields**: All baseline fields.

### 8. Rapid Schema Changes (`8_schema_changes.csv`)
- **Description**: Introduces two new fields (`New-Field-1` and `New-Field-2`) to simulate rapid schema changes.
- **Purpose**: To evaluate how the system reacts to frequent schema modifications and whether proper logging and notifications are in place.
- **Fields**: All baseline fields plus `New-Field-1` and `New-Field-2`.

### 9. Cross-Field Consistency Check (`9_cross_field_consistency.csv`)
- **Description**: Ensures consistency between `Merchant-ID` and `Merchant-Name` using a predefined mapping.
- **Purpose**: To test the pipeline's ability to maintain cross-field consistency and validate relationships between related fields.
- **Fields**: All baseline fields, with consistent mapping between `Merchant-ID` and `Merchant-Name`.

## Summary
These datasets cover a wide range of scenarios to thoroughly test the data pipeline's ability to validate schema integrity, data types, and consistency, handle errors gracefully, and manage high-volume data. Each dataset targets specific aspects of the data quality requirements, ensuring comprehensive testing for robustness, reliability, and scalability of the fintech data pipeline.

