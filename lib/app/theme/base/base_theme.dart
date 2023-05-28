import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:scan_gpt/app/theme/app_borders.dart';

abstract class BaseTheme {
  ThemeData get theme {
    return ThemeData(
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
    ).copyWith(
        typography:
            Typography.material2021(colorScheme: const ColorScheme.dark()),);
  }

  AppBarTheme get _appBarTheme {
    return const AppBarTheme(
      backgroundColor: Color(0xff000000),
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }

  CardTheme get _cardTheme {
    return CardTheme(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.borderRadiusCircular,
      ),
    );
  }

  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.borderRadiusCircular,
        ),
      ),
    );
  }

  InputDecorationTheme get _inputDecorationTheme {
    return const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent, width: 5),
      ),
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 229, 221, 221), width: 2),
      ),
    );
  }
}
