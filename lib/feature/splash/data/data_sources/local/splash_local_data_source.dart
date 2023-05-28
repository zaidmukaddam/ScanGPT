import 'package:injectable/injectable.dart';
import 'package:scan_gpt/app/constants/cache_constants.dart';
import 'package:scan_gpt/core/clients/cache/cache_client.dart';

@injectable
class SplashLocalDataSource {
  SplashLocalDataSource({required CacheClient cacheClient}) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  bool? checkIsOnboardingCompleted() {
    return _cacheClient.getBool(CacheConstants.isOnboardingCompleted);
  }
}
