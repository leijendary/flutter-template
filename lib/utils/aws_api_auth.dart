import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/repositories/session_repository.dart';
import 'package:template/utils/constants.dart';

final container = ProviderContainer();

class AwsApiAuth {
  static Future<String> apiName() async {
    final sessionRepository = container.read(sessionRepositoryProvider);
    final sessionUser = sessionRepository.getUser();

    return sessionUser.isGuest ? ApiAuths.iam : ApiAuths.cognito;
  }
}
