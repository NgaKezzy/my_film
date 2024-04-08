import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: false,
    fontFamily: 'Ubuntu',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      // 4 màu chủ đạo tạo điểm nhấn
      primary: Color(0xFF6196A6),
      onPrimary: Color(0xFFEE4266),
      primaryContainer: Color(0xFF6196A6),
      onPrimaryContainer: Color(0xFFADC4CE),
      secondary: Color(0xFFE493B3),
      onSecondary: Color(0xFFA5DD9B),
      secondaryContainer: Color(0xFFEEA5A6),
      onSecondaryContainer: Color(0xFFF1F0E8),
      // -------------------

      // các màu light
      tertiary: Color(0xFF000000),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF96B6C5),
      onTertiaryContainer: Color(0xFF31111D),
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFF9DEDC),
      onErrorContainer: Color(0xFF410E0B),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xFF1C1B1F),
      surface: Color(0xFF496989),
      onSurface: Color(0xFF1C1B1F),
      surfaceVariant: Color(0xFFE7E0EC),
      onSurfaceVariant: Color(0xFF49454F),
      outline: Color(0xFF79747E),
      outlineVariant: Color(0xFFCAC4D0),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF313033),
      onInverseSurface: Color(0xFFF4EFF4),
      inversePrimary: Color(0xFFD0BCFF),
      // The surfaceTint color is set to the same color as the primary.
      surfaceTint: Color(0xFF6750A4),
    ));
