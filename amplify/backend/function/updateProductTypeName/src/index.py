import os

import boto3

table_name = os.environ.get("API_SAMPLE_PRODUCTTABLE_NAME")
region = os.environ.get("REGION")
table = boto3.resource("dynamodb", region_name=region).Table(table_name)


def handler(event, context):
    data = table.scan()
    count = 0
    result = []

    for item in data['Items']:
        item = table.update_item(
            Key={
                "id": item["id"],
            },
            UpdateExpression="set #tn = :newTypeName",
            ExpressionAttributeNames={
                "#tn": "typeName"
            },
            ExpressionAttributeValues={
                ':newTypeName': event["typeName"],
            },
            ReturnValues="UPDATED_NEW"
        )

        count = count + 1
        result.append(item["Attributes"])

    return {
        "body": {
            "count": count,
            "result": result
        }
    }
