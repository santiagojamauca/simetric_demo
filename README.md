# Environment Setup Guide

This guide outlines the steps to set up an AWS backend for Terraform, including the creation of an S3 bucket for state storage and a DynamoDB table for state locking. Also included is a brief overview of how to run Terraform to create the necessary infrastructure.

## Part 1: Preparing AWS Resources with a Bash Script

### Overview

A Bash script is provided to automate the creation of the necessary AWS resources for the Terraform backend. This includes:

- An S3 bucket for storing the Terraform state files.
- A DynamoDB table for state locking to prevent concurrent execution conflicts.
- *NOTE*: You only need to run this once to create the S3 bucket and DynamoDB table for the Terraform backend.

### Prerequisites

- AWS CLI installed and configured with the necessary permissions.

### Running the Script

1. Ensure the script `setup_terraform_backend.sh` is executable:

   ```bash
   chmod +x setup_terraform_backend.sh
   ```

2. Run the script with your desired AWS region and environment name as the argument:

  ```bash
  ./setup_terraform_backend.sh us-east-1 dev
  ```

## Part 2: Running Terraform

### Overview

The file structure is as follows:

```
├── dev
├── modules
│   ├── eks
│   └── vpc
└── prod
```

* `dev` and `prod` are the environments
- `modules` contains the reusable modules for the infrastructure

Each environment directory contains the Terraform configuration files for the respective environment. The `modules` directory contains the reusable modules for the infrastructure.  This is so we can reuse the same modules across different environments, or include only one module in an environment.

### Prerequisites

- Terraform installed on your local machine.

### Running Terraform

1. Navigate to one of the environment direcotires:

   ```bash
   cd dev
   ```

2. Initialize the Terraform working directory:

   ```bash
    terraform init
    ```

3. Create an execution plan:

    ```bash
    terraform plan -out=plan.out
    ```

4. Apply the changes:

    ```bash
    terraform apply plan.out
    ```
