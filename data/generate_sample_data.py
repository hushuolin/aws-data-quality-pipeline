import pandas as pd
import random
import os
from datetime import datetime, timedelta
import uuid
import numpy as np

# Directory to save the files
output_directory = "data"

# Function to generate a random date
def random_date(start, end):
    return start + timedelta(
        seconds=random.randint(0, int((end - start).total_seconds())),
    )

# List of sample customer names
customer_names = [
    "John Doe", "Jane Smith", "Alice Johnson", "Bob Brown", "Charlie Davis",
    "Eva Green", "Frank Harris", "Grace Lee", "Henry Miller", "Ivy Nelson",
    "Jackie O'Neil", "Kurt Peters", "Laura Quinn", "Mike Rogers", "Nancy Stevens"
]

# List of sample merchants
merchant_names = [
    "Amazon", "Walmart", "Target", "Starbucks", "Uber",
    "Netflix", "Apple Store", "Google Play", "Spotify", "Best Buy",
    "Shell Gas Station", "McDonald's", "Costco", "Home Depot", "Zara"
]

# Common baseline data schema
def generate_baseline_data(num_records):
    if num_records <= 0:
        raise ValueError("Number of records must be greater than zero.")
    data = {
        "Profile-ID": [str(random.randint(1000000, 9999999)) for _ in range(num_records)],
        "Consumer-ID": [f"CUST-{random.randint(1000, 9999)}" for _ in range(num_records)],
        "Customer-Name": [random.choice(customer_names) for _ in range(num_records)],
        "Session-ID": [str(uuid.uuid4()) for _ in range(num_records)],
        "Transaction-Reference": [str(uuid.uuid4()) for _ in range(num_records)],
        "Transaction-Amount": [round(random.uniform(5.0, 500.0), 2) for _ in range(num_records)],
        "Currency": [random.choice(["USD", "EUR", "GBP", "JPY"]) for _ in range(num_records)],
        "Transaction-Type": [random.choice(["Purchase", "Refund", "Debit"]) for _ in range(num_records)],
        "Transaction-Status": [random.choice(["Success", "Failed", "Pending"]) for _ in range(num_records)],
        "Account-Number": [f"ACC-{random.randint(100000, 999999)}" for _ in range(num_records)],
        "Account-Balance": [round(random.uniform(100.0, 10000.0), 2) for _ in range(num_records)],
        "Merchant-ID": [f"MER-{random.randint(1000, 9999)}" for _ in range(num_records)],
        "Merchant-Name": [random.choice(merchant_names) for _ in range(num_records)],
        "Fraud-Flag": [random.choice([True, False]) for _ in range(num_records)],
        "Timestamp": [random_date(datetime(2022, 1, 1), datetime(2023, 1, 1)).strftime("%Y-%m-%d %H:%M:%S") for _ in range(num_records)],
    }
    return pd.DataFrame(data)

# 1. Baseline Schema Validation
baseline_data = generate_baseline_data(100)
baseline_data.to_csv(os.path.join(output_directory, "1_baseline.csv"), index=False)

# 2. New Field Added (add 'Location')
def generate_data_with_new_field(num_records):
    df = generate_baseline_data(num_records)
    df["Location"] = [random.choice(["New York", "London", "Tokyo", "Berlin"]) for _ in range(num_records)]
    return df

new_field_data = generate_data_with_new_field(100)
new_field_data.to_csv(os.path.join(output_directory, "2_new_field.csv"), index=False)

# 3. Missing Field ('Transaction-Amount' removed)
def generate_data_with_missing_field(num_records):
    df = generate_baseline_data(num_records)
    df.drop(columns=["Transaction-Amount"], inplace=True)
    return df

missing_field_data = generate_data_with_missing_field(100)
missing_field_data.to_csv(os.path.join(output_directory, "3_missing_field.csv"), index=False)

# 4. Data Type Change ('Transaction-Amount' to String)
def generate_data_with_changed_type(num_records):
    df = generate_baseline_data(num_records)
    df["Transaction-Amount"] = df["Transaction-Amount"].astype(str)
    return df

changed_type_data = generate_data_with_changed_type(100)
changed_type_data.to_csv(os.path.join(output_directory, "4_data_type_change.csv"), index=False)

# 5. Empty Dataset
empty_data = pd.DataFrame(columns=baseline_data.columns)
empty_data.to_csv(os.path.join(output_directory, "5_empty.csv"), index=False)

# 6. High Volume Data (Generated in Chunks to Save Memory)
chunk_size = 10000
with open(os.path.join(output_directory, "6_high_volume.csv"), mode='w') as f:
    for i in range(0, 100000, chunk_size):
        chunk_data = generate_baseline_data(min(chunk_size, 100000 - i))
        chunk_data.to_csv(f, index=False, header=(i == 0))

# 7. Invalid Data Types ('Transaction-Amount' contains invalid value)
def generate_data_with_invalid_types(num_records):
    df = generate_baseline_data(num_records)
    df.loc[random.randint(0, num_records-1), "Transaction-Amount"] = np.nan
    return df

invalid_type_data = generate_data_with_invalid_types(100)
invalid_type_data.to_csv(os.path.join(output_directory, "7_invalid_data.csv"), index=False)

# 8. Rapid Schema Changes (Simulate multiple schema versions)
def generate_rapid_schema_changes(num_records):
    df = generate_baseline_data(num_records)
    df["New-Field-1"] = [random.choice(["Value1", "Value2"]) for _ in range(num_records)]
    df["New-Field-2"] = [random.randint(0, 100) for _ in range(num_records)]
    return df

rapid_schema_change_data = generate_rapid_schema_changes(100)
rapid_schema_change_data.to_csv(os.path.join(output_directory, "8_schema_changes.csv"), index=False)

# 9. Cross-Field Consistency (Inconsistent 'Merchant-ID' and 'Merchant-Name')
def generate_cross_field_inconsistency(num_records):
    df = generate_baseline_data(num_records)
    # Introduce inconsistency between 'Merchant-ID' and 'Merchant-Name'
    if num_records > 1:
        df.loc[1, "Merchant-Name"] = "Inconsistent Merchant"
    return df

cross_field_inconsistency_data = generate_cross_field_inconsistency(100)
cross_field_inconsistency_data.to_csv(os.path.join(output_directory, "9_cross_field_consistency.csv"), index=False)

# 10. Duplicate Records (for Uniqueness Constraints)
def generate_data_with_duplicates(num_records):
    df = generate_baseline_data(num_records)
    # Introduce a duplicate in Transaction-Reference
    if num_records > 1:
        df.loc[1, "Transaction-Reference"] = df.loc[0, "Transaction-Reference"]
    return df

duplicate_data = generate_data_with_duplicates(100)
duplicate_data.to_csv(os.path.join(output_directory, "10_duplicates.csv"), index=False)

# 11. Field Dependency Testing ('Transaction-Amount' affecting 'Account-Balance')
def generate_data_with_field_dependency(num_records):
    df = generate_baseline_data(num_records)
    for i in range(num_records):
        if df.loc[i, "Transaction-Type"] == "Debit":
            df.loc[i, "Account-Balance"] -= df.loc[i, "Transaction-Amount"]
            if df.loc[i, "Account-Balance"] < 0:
                df.loc[i, "Account-Balance"] = 0  # Ensure no negative balances
    return df

field_dependency_data = generate_data_with_field_dependency(100)
field_dependency_data.to_csv(os.path.join(output_directory, "11_field_dependency.csv"), index=False)

# 12. Invalid Transaction Status Values
def generate_data_with_invalid_status(num_records):
    df = generate_baseline_data(num_records)
    invalid_statuses = ["Processing", "Unknown", "Cancelled"]
    df.loc[random.randint(0, num_records-1), "Transaction-Status"] = random.choice(invalid_statuses)
    return df

invalid_status_data = generate_data_with_invalid_status(100)
invalid_status_data.to_csv(os.path.join(output_directory, "12_invalid_status.csv"), index=False)

print(f"Sample data files have been saved to '{output_directory}' directory.")
