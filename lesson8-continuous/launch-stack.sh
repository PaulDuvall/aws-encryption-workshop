#!/bin/bash
# sudo chmod +x *.sh
# ./launch-stack.sh

sudo rm -rf tmp-gitrepo
mkdir tmp-gitrepo
cd tmp-gitrepo
git clone https://github.com/PaulDuvall/aws-encryption-workshop.git

aws s3api list-buckets --query 'Buckets[?starts_with(Name, `pmd-security-controls-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

sleep 20

aws cloudformation delete-stack --stack-name pmd-security-controls-us-east-1

sleep 50

aws cloudformation delete-stack --stack-name pmd-security-controls

sleep 25

cd lesson8-continuous

aws s3 mb s3://pmd-security-controls-$(aws sts get-caller-identity --output text --query 'Account')
zip -r pmd-security-controls.zip .
mkdir zipfiles
cp ceoa-8-pipeline.yml zipfiles
mv pmd-security-controls.zip zipfiles
cd zipfiles

aws s3 sync . s3://pmd-security-controls-$(aws sts get-caller-identity --output text --query 'Account')

aws cloudformation create-stack --stack-name pmd-security-controls --capabilities CAPABILITY_NAMED_IAM --disable-rollback --template-body file://ceoa-8-pipeline.yml --parameters ParameterKey=EmailAddress,ParameterValue=fake-email@fake-fake-fake-email.com ParameterKey=CodeCommitS3Bucket,ParameterValue=pmd-security-controls-$(aws sts get-caller-identity --output text --query 'Account') ParameterKey=CodeCommitS3Key,ParameterValue=pmd-security-controls.zip ParameterKey=S3ComplianceResourceId,ParameterValue=ceoa-8-s3-unencrypted-$(aws sts get-caller-identity --output text --query 'Account')