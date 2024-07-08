import 'package:flutter/material.dart';

import 'package:challenge_uex/app/core/ui/ui.dart';

class AppTheme {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColorDark,
    primaryColorLight: AppColors.primaryColorLight,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
    ),
    textTheme: _buildTextTheme(),
    inputDecorationTheme: _buildInputDecorationTheme(),
    elevatedButtonTheme: _buildElevatedButtonThemeData(),
  );

  static TextTheme? _buildTextTheme() {
    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColorDark,
      ),
      bodyLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        color: AppColors.primaryColorDark,
      ),
      titleLarge: TextStyle(
        color: AppColors.primaryColorDark,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColorLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.grey.shade100,
      hintStyle: TextStyle(color: AppColors.primaryColor.withOpacity(0.5)),
    );
  }
}
