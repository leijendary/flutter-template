export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "userPoolGroups": {
            "CustomerGroupRole": "string"
        },
        "sample": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "HostedUIDomain": "string",
            "OAuthMetadata": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string",
            "CreatedSNSRole": "string"
        }
    },
    "function": {
        "samplePostConfirmation": {
            "Name": "string",
            "Arn": "string",
            "LambdaExecutionRole": "string",
            "Region": "string"
        },
        "updateMenuTypeName": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "updateProductTypeName": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    },
    "storage": {
        "sample": {
            "BucketName": "string",
            "Region": "string"
        }
    },
    "api": {
        "sample": {
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    }
}