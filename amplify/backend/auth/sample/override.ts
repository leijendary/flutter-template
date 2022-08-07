import { AmplifyAuthCognitoStackTemplate } from '@aws-amplify/cli-extensibility-helper';
import { AWSContext } from "./override.config";

export function override(resources: AmplifyAuthCognitoStackTemplate) {
  const countryCode = {
    attributeDataType: "String",
    developerOnlyAttribute: false,
    mutable: true,
    name: "country_code",
    required: false,
    minLength: 2,
    maxLength: 4
  }

  resources.userPool.schema = [
    ...(resources.userPool.schema as any[]),
    countryCode,
  ]

  if (AWSContext.environment === "dev") {
    resources.userPoolClient.accessTokenValidity = 1;
    resources.userPoolClient.idTokenValidity = 1;
    resources.userPoolClient.tokenValidityUnits = {
      accessToken: "days",
      idToken: "days",
      refreshToken: "days",
    }
    resources.userPoolClient.allowedOAuthFlows = ["implicit"]
    resources.userPoolClient.callbackUrLs = [
      "http://localhost:3000/login/redirect/"
    ];
    resources.userPoolClient.logoutUrLs = [
      "http://localhost:3000/logout/redirect/"
    ];
    resources.userPoolClient.allowedOAuthScopes = ["openid", "profile"];
    resources.userPoolClient.supportedIdentityProviders = ["COGNITO"];
  }
}
