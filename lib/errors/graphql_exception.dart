import 'package:amplify_flutter/amplify_flutter.dart';

class GraphQLResponseException implements Exception {
  GraphQLResponseException(this.errors);

  final List<GraphQLResponseError> errors;

  @override
  String toString() => "GraphQLResponseException: $errors";
}
