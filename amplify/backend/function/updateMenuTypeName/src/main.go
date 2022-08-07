package main

import (
	"context"
	"log"
	"os"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/feature/dynamodb/attributevalue"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
)

type ItemInfo struct {
	Id string `json:"id"`
}

type TypeNameEvent struct {
	TypeName string `json:"typeName"`
}

func HandleRequest(ctx context.Context, typeName TypeNameEvent) (map[string]int, error) {
	region := os.Getenv("REGION")
	tableName := os.Getenv("API_SAMPLE_MENUTABLE_NAME")
	cfg, _ := config.LoadDefaultConfig(context.TODO(), config.WithRegion(region))
	svc := dynamodb.NewFromConfig(cfg)
	out, _ := svc.Scan(context.TODO(), &dynamodb.ScanInput{
		TableName: aws.String(tableName),
	})
	count := 0

	for _, item := range out.Items {
		itemInfo := ItemInfo{}
		_ = attributevalue.UnmarshalMap(item, &itemInfo)
		input := &dynamodb.UpdateItemInput{
			TableName: aws.String(tableName),
			Key: map[string]types.AttributeValue{
				"id": &types.AttributeValueMemberS{
					Value: itemInfo.Id,
				},
			},
			ExpressionAttributeValues: map[string]types.AttributeValue{
				":tn": &types.AttributeValueMemberS{Value: typeName.TypeName},
			},
			ExpressionAttributeNames: map[string]string{
				"#t": "type",
			},
			ReturnValues:     types.ReturnValueUpdatedNew,
			UpdateExpression: aws.String("SET typeName = :tn REMOVE #t"),
		}

		_, err := svc.UpdateItem(context.TODO(), input)

		if err != nil {
			log.Fatalf("Got error calling UpdateItem: %s", err)
		} else {
			count++
		}
	}

	return map[string]int{"count": count}, nil
}

func main() {
	lambda.Start(HandleRequest)
}
