import { AmplifyS3ResourceTemplate } from '@aws-amplify/cli-extensibility-helper';
import { AWSContext } from "./override.config";

export function override(resources: AmplifyS3ResourceTemplate) {
  resources.s3Bucket.bucketEncryption = {
    serverSideEncryptionConfiguration: [
      {
        serverSideEncryptionByDefault: {
          sseAlgorithm: "AES256"
        }
      }
    ]
  }

  if (AWSContext.environment === "prod") {
    resources.s3Bucket.versioningConfiguration = {
      "status": "Enabled"
    }
  }
}
