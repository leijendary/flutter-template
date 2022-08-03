export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "userPoolGroups": {
            "CustomerGroupRole": "string"
        },
        "SampleAuth": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string",
            "CreatedSNSRole": "string"
        }
    },
    "function": {
        "SampleAuthPostConfirmation": {
            "Name": "string",
            "Arn": "string",
            "LambdaExecutionRole": "string",
            "Region": "string"
        }
    },
    "api": {
        "sample": {
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    },
    "storage": {
        "SampleS3": {
            "BucketName": "string",
            "Region": "string"
        }
    }
}