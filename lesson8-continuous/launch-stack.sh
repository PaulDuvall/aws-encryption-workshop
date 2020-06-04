#!/bin/bash
# sudo chmod +x *.sh
# ./launch-stack.sh

TMPDIR=${1:-tmp-gitrepo}   
S3BUCKET=${2:-pmd-security-controls-}
SAMSTACK=${3:-pmd-security-controls-us-east-1}
CFNSTACK=${4:-pmd-security-controls}
PIPELINEYAML=${5:-ceoa-8-pipeline.yml}
UNENCRYPTEDS3BUCKETPREFIX=${6:-ceoa-8-s3-unencrypted}

sudo rm -rf $TMPDIR
mkdir $TMPDIR
cd $TMPDIR
git clone https://github.com/PaulDuvall/aws-encryption-workshop.git

aws configservice delete-config-rule --config-rule-name s3-bucket-server-side-encryption-enabled

aws s3api list-buckets --query 'Buckets[?starts_with(Name, `'$S3BUCKET'`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws s3 rb s3://$UNENCRYPTEDS3BUCKETPREFIX-$(aws sts get-caller-identity --output text --query 'Account') --force

sleep 20

aws cloudformation delete-stack --stack-name $SAMSTACK

sleep 50

aws cloudformation delete-stack --stack-name $CFNSTACK

sleep 25

cd aws-encryption-workshop/lesson8-continuous

aws s3 mb s3://$CFNSTACK-$(aws sts get-caller-identity --output text --query 'Account')
zip -r $CFNSTACK.zip .
mkdir zipfiles
cp $PIPELINEYAML zipfiles
mv $CFNSTACK.zip zipfiles
cd zipfiles

aws s3 sync . s3://$CFNSTACK-$(aws sts get-caller-identity --output text --query 'Account')

aws cloudformation create-stack --stack-name $CFNSTACK --capabilities CAPABILITY_NAMED_IAM --disable-rollback --template-body file://$PIPELINEYAML --parameters ParameterKey=EmailAddress,ParameterValue=fake-email@fake-fake-fake-email.com ParameterKey=CodeCommitS3Bucket,ParameterValue=$CFNSTACK-$(aws sts get-caller-identity --output text --query 'Account') ParameterKey=CodeCommitS3Key,ParameterValue=$CFNSTACK.zip ParameterKey=S3ComplianceResourceId,ParameterValue=ceoa-8-s3-unencrypted-$(aws sts get-caller-identity --output text --query 'Account')