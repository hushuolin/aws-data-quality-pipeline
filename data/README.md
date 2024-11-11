# README for Sample Data Testing Project

## Project Overview
This project provides a comprehensive set of sample datasets for testing a data pipeline in a fintech context. The main objective is to validate the robustness, scalability, and adaptability of the data pipeline under different realistic data scenarios. The data pipeline needs to handle large volumes of transactions while ensuring data integrity, compliance, and consistent performance.

## Test Matrix
The following test matrix gives an overview of the testing scenarios covered by each sample dataset to ensure comprehensive coverage of real-world conditions:

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

## Business Scenario
The datasets are designed for a fintech company providing digital financial services such as peer-to-peer payments, digital wallets, and merchant payments. The company processes a high volume of transactions daily, necessitating robust data integrity, compliance, and scalability.

### Key Business Operations
- **Peer-to-Peer (P2P) Payments**: Instant money transfer between users, with data reflecting the transaction details.
- **Merchant Payments**: Payments for products and services, including merchant identifiers and transaction details.
- **Digital Wallet Management**: Wallet balance management, with fields representing account numbers, balances, and transaction references.

## Sample Datasets Overview
The following datasets are used to evaluate different aspects of the data pipeline:

### 1. Baseline Schema (`1_baseline.csv`)
- **Purpose**: Acts as the reference dataset for comparison against modified datasets.
- **Fields**: `Profile-ID`, `Consumer-ID`, `Customer-Name`, `Session-ID`, `Transaction-Reference`, `Transaction-Amount`, `Currency`, `Transaction-Type`, `Transaction-Status`, `Account-Number`, `Account-Balance`, `Merchant-ID`, `Merchant-Name`, `Fraud-Flag`, `Timestamp`.

### 2. New Field Added (`2_new_field.csv`)
- **Purpose**: Tests the pipeline's ability to handle new fields (`Location`) without issues.
- **Fields**: All baseline fields plus `Location`.

### 3. Missing Field (`3_missing_field.csv`)
- **Purpose**: Tests how the pipeline manages missing mandatory fields like `Transaction-Amount`.
- **Fields**: All baseline fields except `Transaction-Amount`.

### 4. Data Type Change (`4_data_type_change.csv`)
- **Purpose**: Evaluates how the pipeline handles unexpected changes in data types.
- **Fields**: All baseline fields, with `Transaction-Amount` as a string.

### 5. Empty Dataset (`5_empty.csv`)
- **Purpose**: Tests pipeline behavior when the dataset is empty.
- **Fields**: All baseline fields, no data.

### 6. Invalid Data Types (`7_invalid_data.csv`)
- **Purpose**: Assesses resilience to data quality issues, such as invalid values (`NaN`).
- **Fields**: All baseline fields, with `Transaction-Amount` containing invalid values.

### 7. High Volume Dataset (`6_high_volume.csv`)
- **Purpose**: Tests the scalability and performance of the pipeline with 100,000 records.
- **Fields**: All baseline fields.

### 8. Rapid Schema Changes (`8_schema_changes.csv`)
- **Purpose**: Tests adaptability to frequent schema changes by adding `New-Field-1` and `New-Field-2`.
- **Fields**: All baseline fields plus `New-Field-1` and `New-Field-2`.