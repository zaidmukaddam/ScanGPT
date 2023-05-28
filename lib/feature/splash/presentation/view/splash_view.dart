import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:scan_gpt/feature/detector/presentation/view/detect_view.dart';
import 'package:scan_gpt/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:scan_gpt/feature/splash/presentation/cubit/splash_cubit.dart';

import 'package:scan_gpt/injection.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SplashCubit>()..checkIsOnboardingCompleted(),
      child: const Scaffold(
        body: _SplashViewBody(),
      ),
    );
  }
}

class _SplashViewBody extends StatefulWidget {
  const _SplashViewBody();

  @override
  State<_SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<_SplashViewBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkIsOnboardingCompleted());
  }

  void _checkIsOnboardingCompleted() {
    if (context.read<SplashCubit>().state.isOnboardingCompleted ?? false) {
      Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (context) => const DetectView()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (context) => const OnboardingView()));
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
