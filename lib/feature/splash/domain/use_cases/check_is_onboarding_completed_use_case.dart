import 'package:injectable/injectable.dart';
import 'package:scan_gpt/feature/splash/domain/repositories/splash_repository.dart';

@injectable
class CheckIsOnboardingCompletedUseCase {
  CheckIsOnboardingCompletedUseCase({
    required SplashRepository splashRepository,
  }) : _splashRepository = splashRepository;

  final SplashRepository _splashRepository;

  bool? call() {
    return _splashRepository.checkIsOnboardingCompleted();
  }
}
