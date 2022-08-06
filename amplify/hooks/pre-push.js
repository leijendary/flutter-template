const fs = require("fs");
const parameters = JSON.parse(fs.readFileSync(0, { encoding: "utf8" }));
const amplifyMeta = JSON.parse(
  fs.readFileSync("amplify/backend/amplify-meta.json")
);
const resourceName = "sample";
const accountId =
  amplifyMeta.providers.awscloudformation.AuthRoleName.split(":")[4];
const region = amplifyMeta.providers.awscloudformation.Region;
const content = `export const ApiContext = {
  "environment": "${parameters.data.amplify.environment.envName}",
  "resource_name": "${resourceName}",
  "account_id": "${accountId}",
  "region": "${region}"
}`;
try {
  fs.writeFileSync(
    `amplify/backend/api/${resourceName}/override.config.ts`,
    content
  );
  process.exit(0);
} catch (err) {
  console.error(err);
  process.exit(1);
}
