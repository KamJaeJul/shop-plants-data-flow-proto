import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.whiteBackground,
      secondary: AppColors.buttonPrimary,
      onSecondary: AppColors.whiteBackground,
      surface: AppColors.whiteBackground,
      onSurface: AppColors.primaryText,
    ),
    scaffoldBackgroundColor: AppColors.greyBackground,
    fontFamily: AppTypography.fontFamily,
    textTheme: AppTypography.textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.whiteBackground,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.buttonPrimary),
        foregroundColor: WidgetStatePropertyAll(AppColors.whiteBackground),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontWeight: AppTypography.medium,
          ),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.buttonPrimary),
        foregroundColor: WidgetStatePropertyAll(AppColors.whiteBackground),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontWeight: AppTypography.medium,
          ),
        ),
      ),
    ),
  );
}
