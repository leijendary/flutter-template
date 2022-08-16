import 'package:flutter_sample/repositories/session_repository.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final container = ProviderContainer();

class AwsApiAuth {
  static Future<String> apiName() async {
    final sessionRepository = container.read(sessionRepositoryProvider);
    final sessionUser = sessionRepository.getUser();

    return sessionUser.isGuest ? ApiAuths.iam : ApiAuths.cognito;
  }
}
