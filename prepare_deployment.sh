#!/bin/bash

if [[ "$#" -ne 4 ]]; then
    echo "Please provide 4 arguments"
    echo "Example:$0 <bucket name> <component name> <environment> <aws profile name>"
    echo "Example:$0  dragontail-cloudformation-infra-templates dragontail DEV crypto2cash"
    exit 1
fi

BUCKET_NAME=$1
COMPONENT_NAME=$2
ENVIRONMENT=$3
PROFILE_NAME=$4

echo "Syncing the template files to s3..."
aws s3 sync --exclude '*' --include '*.yaml' cd/cloudformation s3://${BUCKET_NAME}/${COMPONENT_NAME}/${ENVIRONMENT} --profile "${PROFILE_NAME}"

echo "done"