import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:scan_gpt/core/extensions/context_extensions.dart';

abstract class SnackbarUtils {
  static void showSnackbar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          padding: context.paddingAllDefault,
          content: Text(message),
        ),
      );
  }
}
