import { AmplifyApiGraphQlResourceStackTemplate } from '@aws-amplify/cli-extensibility-helper';
import { AWSContext } from "./override.config";

export function override(resources: AmplifyApiGraphQlResourceStackTemplate) {
  resources.api.GraphQLAPI.logConfig = {
    cloudWatchLogsRoleArn: `arn:aws:iam::${AWSContext.accountId}:role/service-role/appsync-graphqlapi-logs-${AWSContext.region}`,
    fieldLogLevel: "ERROR",
    excludeVerboseContent: false,
  }
}
