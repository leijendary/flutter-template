import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_sample/models/ModelProvider.dart';

class ETagRepository {
  Future<ETag?> getMenuETag() async {
    return getETag(Menu.schema.name);
  }

  void setMenuETag(ETag? eTag, String? value) {
    // GraphQLRequest<ETag> mutation;

    // if (eTag != null) {
    //   mutation = ModelMutations.update(eTag);
    // } else {
    //   eTag = ETag(
    //     name: Menu.schema.name,
    //     value: value,
    //   );
    //   mutation = ModelMutations.create(eTag);
    // }
    eTag ??= ETag(
      name: Menu.schema.name,
      value: value,
    );

    final mutation = ModelMutations.update(eTag);
    final request = GraphQLRequest<ETag>(
      document: mutation.document,
      decodePath: mutation.decodePath,
      modelType: mutation.modelType,
      variables: mutation.variables,
      apiName: "sample_cognito",
    );

    Amplify.API.mutate(request: request);
  }

  Future<ETag?> getETag(String name) async {
    const getETag = "getETag";
    const query = """
      query (\$name: String!) {
        $getETag(name: \$name) {
          name
          value
        }
      }
    """;
    final request = GraphQLRequest<ETag>(
      document: query,
      modelType: ETag.classType,
      variables: <String, dynamic>{
        "name": name,
      },
      decodePath: getETag,
      apiName: "sample_cognito",
    );
    final response = await Amplify.API.query(request: request).response;

    return response.data;
  }
}
