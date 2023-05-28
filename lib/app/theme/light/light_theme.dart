import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_gpt/app/theme/base/base_theme.dart';

@lazySingleton
class LightTheme extends BaseTheme {
  @override
  ThemeData get theme {
    return ThemeData(
      appBarTheme: super.theme.appBarTheme,
      cardTheme: super.theme.cardTheme,
      elevatedButtonTheme: super.theme.elevatedButtonTheme,
      inputDecorationTheme: super.theme.inputDecorationTheme,
      colorScheme: _colorScheme,
      textTheme: GoogleFonts.spaceGroteskTextTheme(),
    ).copyWith(typography: super.theme.typography);
  }

  ColorScheme get _colorScheme {
    // Dark theme
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff6200ee),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbb86fc),
      onPrimaryContainer: Color(0xff100c14),
      secondary: Color(0xff03dac6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcefaf8),
      onSecondaryContainer: Color(0xff111414),
      tertiary: Color.fromARGB(255, 156, 246, 246),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color.fromARGB(255, 78, 221, 216),
      onTertiaryContainer: Color(0xff0e1414),
      error: Color(0xffb00020),
      onError: Color(0xffffffff),
      errorContainer: Color.fromARGB(255, 230, 105, 130),
      onErrorContainer: Color(0xff141213),
      background: Color(0xff000000),
      onBackground: Color(0xffffffff),
      surface: Color(0xfff9f6fe),
      onSurface: Color(0xff090909),
      surfaceVariant: Color(0xfff3edfd),
      onSurfaceVariant: Color(0xff131213),
      outline: Color(0xff565656),
      shadow: Color(0xff000000),
      inverseSurface: Color(0xff131018),
      onInverseSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xffda99ff),
      surfaceTint: Color(0xff6200ee),
    );
  }
}
