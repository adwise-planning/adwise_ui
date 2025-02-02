import 'package:Adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: AppConstants.primaryColor,
  colorScheme: ColorScheme.light(
    primary: AppConstants.primaryColor,
    secondary: AppConstants.accentColor,
    surface: Colors.white,
    onPrimary: Colors.white, // Text on primary color
    onSecondary: Colors.white, // Text on accent color
    onSurface: AppConstants.primaryColor, // Text on light backgrounds
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppConstants.primaryColor),
    bodyMedium: TextStyle(color: AppConstants.primaryColor),
    titleLarge: TextStyle(color: AppConstants.primaryColor),
    titleMedium: TextStyle(color: AppConstants.primaryColor),
    labelLarge: TextStyle(color: Colors.white), // Buttons
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppConstants.primaryColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppConstants.accentColor,
    foregroundColor: Colors.white,
  ),
);

final darkTheme = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: AppConstants.primaryColor,
  colorScheme: ColorScheme.dark(
    primary: AppConstants.primaryColor,
    secondary: AppConstants.accentColor,
    surface: Colors.grey[900]!,
    onPrimary: Colors.white, // Text on primary color
    onSecondary: Colors.white, // Text on accent color
    onSurface: Colors.white, // Text on dark backgrounds
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: TextTheme(
    bodyLarge: const TextStyle(color: Colors.white),
    bodyMedium: const TextStyle(color: Colors.white),
    titleLarge: const TextStyle(color: Colors.white),
    titleMedium: const TextStyle(color: Colors.white),
    labelLarge: const TextStyle(color: Colors.white), // Buttons
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppConstants.primaryColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppConstants.accentColor,
    foregroundColor: Colors.white,
  ),
);