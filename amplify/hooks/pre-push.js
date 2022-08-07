const fs = require("fs");
const parameters = JSON.parse(fs.readFileSync(0, { encoding: "utf8" }));
const amplifyMeta = JSON.parse(
  fs.readFileSync("amplify/backend/amplify-meta.json")
);
const accountId =
  amplifyMeta.providers.awscloudformation.AuthRoleArn.split(":")[4];
const region = amplifyMeta.providers.awscloudformation.Region;
const resources = ["api/sample", "auth/sample", "storage/sample"];
const content = `export const AWSContext = {
  "environment": "${parameters.data.amplify.environment.envName}",
  "accountId": "${accountId}",
  "region": "${region}"
}`;

try {
  for (const resource of resources) {
    fs.writeFileSync(`amplify/backend/${resource}/override.config.ts`, content);
  }

  process.exit(0);
} catch (err) {
  console.error(err);

  process.exit(1);
}
