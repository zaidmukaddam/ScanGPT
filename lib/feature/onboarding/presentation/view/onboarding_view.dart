import 'dart:async';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/neopop.dart';
import 'package:scan_gpt/app/l10n/l10n.dart';
import 'package:scan_gpt/core/extensions/context_extensions.dart';
import 'package:scan_gpt/core/extensions/widget_extensions.dart';
import 'package:scan_gpt/feature/detector/presentation/view/detect_view.dart';
import 'package:scan_gpt/feature/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:scan_gpt/injection.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => getIt<OnboardingCubit>(),
        child: const _OnboardingViewBody(),
      ),
    );
  }
}

class _OnboardingViewBody extends StatelessWidget {
  const _OnboardingViewBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/icons/logo_circle.png',
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ),
            Center(
              child: Text(
                context.l10n.appName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              context.l10n.onboardingInfo1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              context.l10n.onboardingInfo2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: context.width,
                  height: context.highValue,
                  child: NeoPopButton(
                    onTapDown: () async {
                      await context
                          .read<OnboardingCubit>()
                          .completeOnboarding();
                      if (context.mounted) {
                        unawaited(
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const DetectView(),
                            ),
                          ),
                        );
                      }
                    },
                    onTapUp: HapticFeedback.vibrate,
                    color: Colors.greenAccent,
                    child: const Center(
                      child: Text(
                        'Get Started →',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
              .animate(interval: 400.ms)
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad)
              .spaceBetween(height: context.mediumValue),
        ),
      ),
    );
  }
}
