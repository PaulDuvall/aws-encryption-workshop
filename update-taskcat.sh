#!/usr/bin/env bash
# sudo chmod +x *.sh
# ./update-taskcat.sh my-pipeline-name-bucket

#This shell script updates Postman environment file with the API Gateway URL created
# via the api gateway deployment

echo "Running update-taskcat.sh"

PIPELINE_BUCKET=${1:-junk}   

echo "$PIPELINE_BUCKET is $PIPELINE_BUCKET"

sed -i "s/S3_BUCKET_TOKEN/$PIPELINE_BUCKET/g" .taskcat.yml

echo "Updated update-taskcat.sh"

cat .taskcat.yml