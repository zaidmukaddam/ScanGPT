import 'package:injectable/injectable.dart';
import 'package:scan_gpt/feature/onboarding/data/data_sources/local/onboarding_local_data_source.dart';
import 'package:scan_gpt/feature/onboarding/domain/repositories/onboarding_repository.dart';

@Injectable(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl({required OnboardingLocalDataSource onboardingLocalDataSource})
      : _onboardingLocalDataSource = onboardingLocalDataSource;

  final OnboardingLocalDataSource _onboardingLocalDataSource;

  @override
  Future<void> completeOnboarding() async {
    await _onboardingLocalDataSource.completeOnboarding();
  }
}
