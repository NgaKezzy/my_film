import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
    useMaterial3: false,
    fontFamily: 'Ubuntu',
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      // 4 màu chủ đạo
      primary: Color(0xFF282a36),
      onPrimary: Color(0xFFEE4266),
      primaryContainer: Color(0xFF6196A6),
      onPrimaryContainer: Color(0xFF1B4242),
      secondary: Color(0xFFE493B3),
      onSecondary: Color(0xFF5C8374),
      secondaryContainer: Color(0xFFEEA5A6),
      onSecondaryContainer: Color(0xFF9EC8B9),
      // -------------------------------

      // các màu dark
      tertiary: Color(0xFFFFFFFF),

      onTertiary: Color(0xFF492532),
      tertiaryContainer: Color(0xFF96B6C5),
      onTertiaryContainer: Color(0xFFFFD8E4),
      error: Color(0xFFFF0000),
      onError: Color(0xFF601410),
      errorContainer: Color(0xFF8C1D18),
      onErrorContainer: Color(0xFFF9DEDC),
      background: Color(0xFF1C1B1F),
      onBackground: Color(0xFFE6E1E5),
      surface: Color(0xFF496989),
      onSurface: Color(0xFFE6E1E5),
      surfaceVariant: Color(0xFF49454F),
      onSurfaceVariant: Color(0xFFCAC4D0),
      outline: Color(0xFF938F99),
      outlineVariant: Color(0xFF49454F),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFE6E1E5),
      onInverseSurface: Color(0xFF313033),
      inversePrimary: Color(0xFF6750A4),
      // The surfaceTint color is set to the same color as the primary.
      surfaceTint: Color(0xFFD0BCFF),
    ));
