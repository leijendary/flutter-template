import { AmplifyApiGraphQlResourceStackTemplate } from '@aws-amplify/cli-extensibility-helper';

export function override(resources: AmplifyApiGraphQlResourceStackTemplate) {
  resources.api.GraphQLAPI.logConfig = {
    cloudWatchLogsRoleArn: "arn:aws:iam::390029653531:role/service-role/appsync-graphqlapi-logs-eu-central-1",
    fieldLogLevel: "ERROR",
    excludeVerboseContent: false,
  }
}
