var AWS = require('aws-sdk');

exports.handler = function(event) {
  console.log("request:", JSON.stringify(event, undefined, 2));

    var s3 = new AWS.S3({apiVersion: '2006-03-01'});
    var resource = event['detail']['configurationItem']['configuration'];
    console.log("evaluations:", JSON.stringify(resource, null, 2));
    
  if (resource["complianceType"] == "NON_COMPLIANT")
  {
      console.log(resource["targetResourceId"]);
      var params = {
        Bucket: resource["targetResourceId"],
        ServerSideEncryptionConfiguration: { /* required */
          Rules: [ /* required */
            {
              ApplyServerSideEncryptionByDefault: {
                SSEAlgorithm: "AES256"
              }
            },
          ]
        },
      };
      s3.putBucketEncryption(params, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else     console.log(data);           // successful response
      });
}
};