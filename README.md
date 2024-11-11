# AWS Data Quality Assurance and Schema Consistency Pipeline

## Project Overview
This project is an AWS-based data quality assurance and schema consistency alert pipeline. It ensures that data ingested into S3 follows a consistent schema and detects any changes that could affect downstream processes. The solution uses AWS Glue, EventBridge, SQS, SNS, and Lambda to provide automated schema validation, cross-account event handling, and alert notifications.

## Features
- **Automated Schema Validation**: Uses AWS Glue Crawler to detect schema changes in ingested data.
- **Cross-Account Event Handling**: Routes schema change events across AWS accounts using EventBridge for better data isolation and security.
- **Notification System**: Alerts data engineers of schema changes using SQS, SNS, and AWS Lambda.
- **Compliance Logs**: Stores schema validation results and alerts in S3 for audit and compliance.

## Architecture
The solution is built using the following AWS components:
- **AWS S3**: Storage for raw and processed datasets.
- **AWS Glue**: Crawls the data to generate and update schema information.
- **AWS EventBridge**: Monitors schema changes and routes events across accounts.
- **AWS SQS and SNS**: Queues and topics for alert notification.
- **AWS Lambda**: Processes events and triggers notifications.

## Directory Structure
```
aws-data-quality-pipeline/
├── data/                     # Sample test data with edge cases
├── docs/                     # Documentation including project explations and usage guides
├── src/                      # Source code for Lambda functions and other application logic
│   ├── lambda/               # AWS Lambda function jobs
│   └── utilities/            # Helper functions and utility scripts
├── tests/                    # Unit and integration  end-to-end validation
├── infra/                    # CloudFormation templates for AWS infrastructure
├── scripts/                  # Scripts for deployment, automation, and setup
├── config/                   # Configuration files for different environments (e.g., dev, prod)
└── README.md                 # Project documentation overview
```

## Getting Started
### Prerequisites
- **AWS Account**: You'll need credentials with sufficient permissions to manage AWS services like S3, Glue, Lambda, EventBridge, and SNS.
- **Python 3.8 or Higher**: Install Python from [python.org](https://www.python.org/downloads/).
- **AWS CLI**: Install and configure the AWS CLI to interact with AWS services.
- **Git**: Install Git to manage the project version control.

### Setup Instructions
1. **Clone the Repository**:
   ```bash
   git clone git@github.com:hushuolin/aws-data-quality-pipeline.git
   cd aws-data-quality-pipeline
   ```
2. **Create Virtual Environment and Install Dependencies**:
   ```bash
   python -m venv venv
   source venv/bin/activate  
   pip install -r requirements.txt
   ```
3. **Configure AWS CLI**:
   ```bash
   aws configure
   ```
   Provide your **Access Key ID**, **Secret Access Key**, **Default Region**, and **Default Output Format**.

## Usage
- **Deploy Infrastructure**: Use CloudFormation templates in the `templates/` directory to set up the required AWS infrastructure.
- **Run Tests**: Use `pytest` to run unit and integration tests to validate the pipeline.
- **Monitor Alerts**: Any detected schema changes will trigger SNS notifications to alert the data engineering team.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for improvements or bug fixes.

## Contact
For questions or feedback, please contact the project maintainer at shuolin96@gmail.com.
