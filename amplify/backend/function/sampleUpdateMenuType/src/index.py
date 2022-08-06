import json
import os

import boto3

table_name = os.environ.get("API_SAMPLE_MENUTABLE_NAME")
region = os.environ.get("REGION")
table = boto3.resource("dynamodb", region_name=region).Table(table_name)


def handler(event, context):
    print('received event:')
    print(event)

    data = table.scan()
    count = 0

    for item in data:
        table.update_item(
            Key={
                "pkey": item.id
            },
            AttributeUpdates={
                "type": event.arguments.type
            }
        )

        count = count + 1

    return {
        "body": {
            "count": count
        }
    }
