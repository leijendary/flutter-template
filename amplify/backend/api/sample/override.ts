import { AmplifyApiGraphQlResourceStackTemplate } from '@aws-amplify/cli-extensibility-helper';
import { ApiContext } from './override.config';

export function override(resources: AmplifyApiGraphQlResourceStackTemplate) {
  resources.api.GraphQLAPI.logConfig = {
    cloudWatchLogsRoleArn: `arn:aws:iam::${ApiContext.account_id}:role/service-role/appsync-graphqlapi-logs-${ApiContext.region}`,
    fieldLogLevel: "ERROR",
    excludeVerboseContent: false,
  }
}
