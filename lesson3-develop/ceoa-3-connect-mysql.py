import mysql.connector
import boto3
import json
from botocore.exceptions import ClientError

def get_secret():
    secret_name = "MyRDSInstanceRotationSecret-W2tKLVGFlSD7"
    region_name = "us-east-1"

    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name,
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        if e.response['Error']['Code'] == 'ResourceNotFoundException':
            print("The requested secret " + secret_name + " was not found")
        elif e.response['Error']['Code'] == 'InvalidRequestException':
            print("The request was invalid due to:", e)
        elif e.response['Error']['Code'] == 'InvalidParameterException':
            print("The request had invalid params:", e)
    else:
        # Secrets Manager decrypts the secret value using the associated KMS CMK
        # Depending on whether the secret was a string or binary, only one of these fields will be populated
        if 'SecretString' in get_secret_value_response:
            text_secret_data = get_secret_value_response['SecretString']
            # print(text_secret_data)

            jsonSecretData = json.loads(text_secret_data)
            secretHostname = jsonSecretData["host"]
            secretUsername = jsonSecretData["username"]
            secretPassword = jsonSecretData["password"]

            mydb = mysql.connector.connect(
              host=secretHostname,
              user=secretUsername,
              passwd=secretPassword
            )
            print(mydb)
        else:
            binary_secret_data = get_secret_value_response['SecretBinary']

        # Your code goes here.
        
get_secret()

