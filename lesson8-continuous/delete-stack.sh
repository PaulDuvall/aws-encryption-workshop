#!/bin/bash
# sudo chmod +x *.sh
# ./delete-stack.sh

TMPDIR=${1:-tmp-gitrepo}   
S3BUCKET=${2:-stelligent-security-}
SAMSTACK=${3:-stelligent-security-us-east-1}
CFNSTACK=${4:-stelligent-security}
PIPELINEYAML=${5:-ceoa-8-pipeline.yml}
UNENCRYPTEDS3BUCKETPREFIX=${6:-ceoa-8-s3-unencrypted}

sudo rm -rf $TMPDIR

aws configservice delete-config-rule --config-rule-name s3-bucket-server-side-encryption-enabled

aws s3api list-buckets --query 'Buckets[?starts_with(Name, `'$S3BUCKET'`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws s3 rb s3://$UNENCRYPTEDS3BUCKETPREFIX-$(aws sts get-caller-identity --output text --query 'Account') --force

sleep 20

aws cloudformation delete-stack --stack-name $SAMSTACK

sleep 50

aws cloudformation delete-stack --stack-name $CFNSTACK