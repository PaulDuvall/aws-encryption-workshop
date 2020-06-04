#!/bin/bash
# sudo chmod +x *.sh
# ./test.sh

echo "First->"  $1
echo "Second->" $2

TMPDIR=${1:-tmp-gitrepo}   
S3BUCKET=pmd-test
# S3BUCKET=pmd-security

# fname=CodeDeployHook_preTrafficHook
# aws lambda list-functions --query "Functions[?FunctionName == '$fname'].Role" --output text

aws s3api list-buckets --query 'Buckets[?starts_with(Name, `'$S3BUCKET'`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force




