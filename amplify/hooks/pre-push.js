const fs = require("fs");
const parameters = JSON.parse(fs.readFileSync(0, { encoding: "utf8" }));
const amplifyMeta = JSON.parse(
  fs.readFileSync("amplify/backend/amplify-meta.json")
);
const accountId =
  amplifyMeta.providers.awscloudformation.AuthRoleArn.split(":")[4];
const region = amplifyMeta.providers.awscloudformation.Region;
const apiResourceName = "sample";
const apiContextContent = `export const ApiContext = {
  "environment": "${parameters.data.amplify.environment.envName}",
  "resource_name": "${apiResourceName}",
  "account_id": "${accountId}",
  "region": "${region}"
}`;
const authResourceName = "sample";
const authContextContent = `export const AuthContext = {
  "environment": "${parameters.data.amplify.environment.envName}",
  "resource_name": "${authResourceName}",
  "account_id": "${accountId}",
  "region": "${region}"
}`;
const prefix = "amplify/backend";
const suffix = "override.config.ts";

try {
  fs.writeFileSync(
    `${prefix}/api/${apiResourceName}/${suffix}`,
    apiContextContent
  );
  fs.writeFileSync(
    `${prefix}/auth/${authResourceName}/${suffix}`,
    authContextContent
  );

  process.exit(0);
} catch (err) {
  console.error(err);

  process.exit(1);
}
