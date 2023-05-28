import 'package:injectable/injectable.dart';
import 'package:scan_gpt/app/constants/cache_constants.dart';
import 'package:scan_gpt/core/clients/cache/cache_client.dart';

@injectable
class OnboardingLocalDataSource {
  OnboardingLocalDataSource({required CacheClient cacheClient}) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  Future<void> completeOnboarding() async {
    await _cacheClient.setBool(CacheConstants.isOnboardingCompleted, true);
  }
}
