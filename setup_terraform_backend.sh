#!/bin/bash

# Constants for resource names base
BUCKET_BASE_NAME="tfstate"
DYNAMODB_TABLE_BASE="terraform-locks"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI could not be found. Please install it to proceed."
    exit 1
fi

# Input validation
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <region> <environment>"
    exit 1
fi

REGION=$1
ENVIRONMENT=$2

# Validate the provided region
if ! aws ec2 describe-regions --region-names "$REGION" >/dev/null 2>&1; then
    echo "Invalid AWS region: ${REGION}"
    exit 1
fi

# Update resource names to include the environment
BUCKET_NAME="${BUCKET_BASE_NAME}-${ENVIRONMENT}"
DYNAMODB_TABLE="${DYNAMODB_TABLE_BASE}-${ENVIRONMENT}"

# Function to check if S3 bucket exists
check_s3_bucket_exists() {
    if aws s3api head-bucket --bucket "$1" 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to check if DynamoDB table exists
check_dynamodb_table_exists() {
    if aws dynamodb describe-table --table-name "$1" --region "$REGION" 2>/dev/null; then
        return 0
    else
        return 1
    fi
}


# Create S3 bucket for Terraform state
if check_s3_bucket_exists $BUCKET_NAME; then
    echo "S3 bucket already exists: ${BUCKET_NAME}"
else
    echo "Creating S3 bucket: ${BUCKET_NAME} in region ${REGION}"
    if ! aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION 2>/dev/null; then
        if ! aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION; then
            echo "Failed to create S3 bucket: ${BUCKET_NAME}"
            exit 1
        fi
    fi

    echo "Enabling versioning on S3 bucket: ${BUCKET_NAME}"
    if ! aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled; then
        echo "Failed to enable versioning on S3 bucket: ${BUCKET_NAME}"
        exit 1
    fi
fi

# Create DynamoDB table for Terraform locks
if check_dynamodb_table_exists $DYNAMODB_TABLE; then
    echo "DynamoDB table already exists: ${DYNAMODB_TABLE}"
else
    echo "Creating DynamoDB table: ${DYNAMODB_TABLE} in region ${REGION}"
    if ! aws dynamodb create-table \
        --table-name $DYNAMODB_TABLE \
        --attribute-definitions AttributeName=LockID,AttributeType=S \
        --key-schema AttributeName=LockID,KeyType=HASH \
        --billing-mode PAY_PER_REQUEST \
        --region $REGION; then
        echo "Failed to create DynamoDB table: ${DYNAMODB_TABLE}"
        exit 1
    fi
fi

echo "Resources created successfully!"
echo "S3 bucket: ${BUCKET_NAME}"
echo "DynamoDB table: ${DYNAMODB_TABLE}"