import 'package:injectable/injectable.dart';
import 'package:scan_gpt/feature/onboarding/domain/repositories/onboarding_repository.dart';

@injectable
class CompleteOnboardingUseCase {
  CompleteOnboardingUseCase({
    required OnboardingRepository onboardingRepository,
  }) : _onboardingRepository = onboardingRepository;

  final OnboardingRepository _onboardingRepository;

  Future<void> call() async {
    await _onboardingRepository.completeOnboarding();
    return;
  }
}
