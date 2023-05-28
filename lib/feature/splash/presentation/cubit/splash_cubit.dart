import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_gpt/feature/splash/domain/use_cases/check_is_onboarding_completed_use_case.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required CheckIsOnboardingCompletedUseCase checkIsOnboardingCompletedUseCase})
      : _checkIsOnboardingCompletedUseCase = checkIsOnboardingCompletedUseCase,
        super(SplashState.initial());

  final CheckIsOnboardingCompletedUseCase _checkIsOnboardingCompletedUseCase;

  void checkIsOnboardingCompleted() {
    final result = _checkIsOnboardingCompletedUseCase.call();
    if (result == null || result == false) {
      emit(state.copyWith(isOnboardingCompleted: false));
    } else {
      emit(state.copyWith(isOnboardingCompleted: true));
    }
  }
}
