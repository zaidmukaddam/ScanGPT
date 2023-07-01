import 'package:countup/countup.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_inputs/form_inputs.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bs;
import 'package:neopop/neopop.dart';
import 'package:scan_gpt/app/constants/assets.dart';
import 'package:scan_gpt/app/l10n/l10n.dart';
import 'package:scan_gpt/core/extensions/context_extensions.dart';
import 'package:scan_gpt/core/extensions/widget_extensions.dart';
import 'package:scan_gpt/core/utils/snackbar/snackbar_utils.dart';
import 'package:scan_gpt/feature/detector/presentation/cubit/detector_cubit.dart';
import 'package:scan_gpt/feature/detector/presentation/widgets/gpt_text_field.dart';
// import 'package:scan_gpt/feature/settings/presentation/view.dart';
import 'package:scan_gpt/injection.dart';

class DetectView extends StatelessWidget {
  const DetectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.appName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
          child: SvgPicture.asset(
            Assets.appIcon,
            fit: BoxFit.scaleDown,
            height: 18,
            width: 21,
          ),
        ),
        // actions: [
        //   IconButton(
        //     // ignore: inference_failure_on_function_invocation
        //     onPressed: () => bs.showBarModalBottomSheet(
        //       context: context,
        //       builder: (context) => const SettingsView(),
        //     ),
        //     icon: const Icon(
        //       FluentIcons.settings_48_regular,
        //       size: 34,
        //     ),
        //   )
        // ],
      ),
      backgroundColor: const Color(0xff000000),
      body: BlocProvider(
        create: (context) => getIt<DetectorCubit>(),
        child: _DetectViewBody(),
      ),
    );
  }
}

class _DetectViewBody extends StatefulWidget {
  @override
  State<_DetectViewBody> createState() => _DetectViewBodyState();
}

class _DetectViewBodyState extends State<_DetectViewBody> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetectorCubit, DetectorState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          state.failure!.whenOrNull(
            networkFailure: () => SnackbarUtils.showSnackbar(
              context: context,
              message: context.l10n.networkFailure,
            ),
            noInternetFailure: () => SnackbarUtils.showSnackbar(
              context: context,
              message: context.l10n.noInternetFailure,
            ),
          );
          if (state.status.isSubmissionSuccess && !state.result.isSupportedLanguage) {
          SnackbarUtils.showSnackbar(
            context: context,
            message: context.l10n.unsupportedLanguage,
          );
        }
        }
      },
      child: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: NeoPopCard(
                      color: context.theme.colorScheme.tertiaryContainer,
                      child: SizedBox(
                        height: context.highValue,
                        child: Center(
                          child: BlocSelector<DetectorCubit, DetectorState,
                              double>(
                            selector: (state) => state.result.realProb,
                            builder: (context, state) {
                              return Countup(
                                begin: 0,
                                end: state,
                                precision: 2,
                                duration: context.durationHigh,
                                suffix: context.l10n.percentOriginal,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: NeoPopCard(
                      color: context.theme.colorScheme.errorContainer,
                      child: SizedBox(
                        height: context.highValue,
                        child: Center(
                          child: BlocSelector<DetectorCubit, DetectorState,
                              double>(
                            selector: (state) => state.result.fakeProb,
                            builder: (context, state) {
                              return Countup(
                                precision: 2,
                                begin: 0,
                                end: state,
                                duration: context.durationHigh,
                                suffix: context.l10n.percentAI,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ].spaceBetween(width: context.mediumValue),
              ),
              Expanded(
                child: Stack(
                  children: [
                    GPTTextField(
                      controller: _controller,
                      onChanged: (text) =>
                          context.read<DetectorCubit>().textChanged(text: text),
                      hintText: context.l10n.textFieldHint,
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          FluentIcons.delete_24_regular,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _controller.clear();
                          context.read<DetectorCubit>().clearTextPressed();
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              FluentIcons.image_24_regular,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await context.read<DetectorCubit>().ocrFromGalleryPressed();
                              if (context.mounted) {
                                _controller.text = context.read<DetectorCubit>().state.userInput.value;
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              FluentIcons.camera_sparkles_24_regular,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await context.read<DetectorCubit>().ocrFromCameraPressed();
                              if (context.mounted) {
                                _controller.text = context.read<DetectorCubit>().state.userInput.value;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocSelector<DetectorCubit, DetectorState, bool>(
                    selector: (state) => state.status.isValidated,
                    builder: (context, state) {
                      return !state
                          ? Text(
                              context.l10n.textFieldHelper,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.textTheme.bodySmall?.fontSize,
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  BlocSelector<DetectorCubit, DetectorState, int>(
                    selector: (state) => state.userInput.value.trim().length,
                    builder: (context, state) {
                      return Text(
                        context.l10n.textFieldCounterText(state),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.textTheme.bodySmall?.fontSize,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 500,
                height: 65,
                child: BlocBuilder<DetectorCubit, DetectorState>(
                  buildWhen: (previous, current) =>
                      (previous.status.isValidated &&
                          !previous.status.isSubmissionInProgress) !=
                      (current.status.isValidated &&
                          !current.status.isSubmissionInProgress),
                  builder: (context, state) {
                    return NeoPopTiltedButton(
                      isFloating: true,
                      // color: const Color.fromRGBO(255, 235, 52, 1),
                      decoration: const NeoPopTiltedButtonDecoration(
                        shimmerDelay: Duration(milliseconds: 100),
                        color: Color(0xFFffeb32),
                        plunkColor: Color(0xFFffeb32),
                        shadowColor: Colors.transparent,
                        disabledColor: Color(0xFFffeb32),
                        disabledPlunkColor: Color(0xFFffeb32),
                        showShimmer: true,
                      ),
                      onTapUp: state.status.isValidated &&
                              !state.status.isSubmissionInProgress
                          ? () => context
                              .read<DetectorCubit>()
                              .detectionRequested(text: _controller.text)
                          : null,
                      child: state.status.isSubmissionInProgress
                          ? const Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  // strokeWidth: 5,
                                ),
                              ),
                            )
                          : const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FluentIcons.scan_text_28_regular,
                                    size: 25,
                                    color: Color(0xFF000000),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Scan Text',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  },
                ),
              ),
            ].spaceBetween(height: context.mediumValue),
          ),
        ),
      ),
    );
  }
}
