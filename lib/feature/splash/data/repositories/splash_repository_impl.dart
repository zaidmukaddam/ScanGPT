import 'package:injectable/injectable.dart';
import 'package:scan_gpt/feature/splash/data/data_sources/local/splash_local_data_source.dart';
import 'package:scan_gpt/feature/splash/domain/repositories/splash_repository.dart';

@Injectable(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl({required SplashLocalDataSource splashLocalDataSource})
      : _splashLocalDataSource = splashLocalDataSource;

  final SplashLocalDataSource _splashLocalDataSource;
  @override
  bool? checkIsOnboardingCompleted() {
    return _splashLocalDataSource.checkIsOnboardingCompleted();
  }
}
