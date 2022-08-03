import { AmplifyAuthCognitoStackTemplate } from '@aws-amplify/cli-extensibility-helper';

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
}
