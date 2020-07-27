#!/bin/bash
# sudo chmod +x *.sh
# ./delete-TASKCAT_CODE.sh 

PREFIX=tCaT
S3_PREFIX=tcat
# Name used in .taskcat.yml
PROJECT_NAME=ce

AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/\(.*\)[a-z]/\1/')

# Generated Code by TASKCAT_CODE. For example: 7806754vf2r1494aa8b64d1av821418881
TASKCAT_CODE=${1:-TBD}  
# Generated App Code for Nested Stacks. For example: 2G44LSVW82291
NESTED_APP_CODE=${2:-TBD}

echo Environment: $TASKCAT_CODE

echo "Removing buckets previously used by this script"
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `'$S3_PREFIX-$PROJECT_NAME'`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

# Lesson 8
echo "Deleting $PREFIX-$PROJECT_NAME-l8-$TASKCAT_CODE-$AWS_REGION stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l8-$TASKCAT_CODE-$AWS_REGION
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l8-$TASKCAT_CODE-$AWS_REGION

echo "Deleting $PREFIX-$PROJECT_NAME-l8-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l8-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l8-$TASKCAT_CODE

# Lesson 6
echo "Deleting $PREFIX-$PROJECT_NAME-l6-detect-$TASKCAT_CODE-$AWS_REGION stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l6-detect-$TASKCAT_CODE-$AWS_REGION
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l6-detect-$TASKCAT_CODE-$AWS_REGION

echo "Deleting $PREFIX-$PROJECT_NAME-l6-detect-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l6-detect-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l6-detect-$TASKCAT_CODE

# Lesson 5
echo "Deleting $PREFIX-$PROJECT_NAME-l5-rest-ddb-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l5-rest-ddb-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l5-rest-ddb-$TASKCAT_CODE

echo "Deleting $PREFIX-$PROJECT_NAME-l5-rest-ebs-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l5-rest-ebs-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l5-rest-ebs-$TASKCAT_CODE

echo "Deleting $PREFIX-$PROJECT_NAME-l5-rest-kms-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l5-rest-kms-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l5-rest-kms-$TASKCAT_CODE

echo "Deleting $PREFIX-$PROJECT_NAME-l5-rest-s3-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l5-rest-s3-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l5-rest-s3-$TASKCAT_CODE

# Lesson 4
echo "Deleting $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE-cloudfront stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE-cloudfront
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE-cloudfront

echo "Deleting $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE-acm stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE-acm
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE-acm

echo "Deleting $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l4-$TASKCAT_CODE

# Lesson 3
echo "Deleting $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-rds stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-rds
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-rds

echo "Deleting $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION

echo "Deleting $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-lambda stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-lambda
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-lambda

echo "Deleting $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-vpc stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-vpc
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE-$AWS_REGION-vpc

echo "Deleting $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-l3-$TASKCAT_CODE

# Lesson 1
echo "Deleting $PREFIX-$PROJECT_NAME-lesson1-pipeline-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-lesson1-pipeline-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-lesson1-pipeline-$TASKCAT_CODE

echo "Deleting $PREFIX-$PROJECT_NAME-lesson1-automate-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-lesson1-automate-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-lesson1-automate-$TASKCAT_CODE


echo "Deleting $PREFIX-$PROJECT_NAME-lesson1-pipeline-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-lesson1-pipeline-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-lesson1-pipeline-$TASKCAT_CODE

echo "Deleting $PREFIX-$PROJECT_NAME-lesson1-automate-$TASKCAT_CODE stack"
aws cloudformation delete-stack --stack-name $PREFIX-$PROJECT_NAME-lesson1-automate-$TASKCAT_CODE
aws cloudformation wait stack-delete-complete --stack-name $PREFIX-$PROJECT_NAME-lesson1-automate-$TASKCAT_CODE
