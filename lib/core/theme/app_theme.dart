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
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppConstants.primaryColor, fontFamily: AppConstants.fontFamily),
    bodyMedium: TextStyle(color: AppConstants.primaryColor, fontFamily: AppConstants.fontFamily),
    titleLarge: TextStyle(color: AppConstants.primaryColor, fontFamily: AppConstants.fontFamily),
    titleMedium: TextStyle(color: AppConstants.primaryColor, fontFamily: AppConstants.fontFamily),
    labelLarge: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily), // Buttons
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppConstants.primaryColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: AppConstants.fontFamily,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
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
    bodyLarge: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    bodyMedium: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    titleLarge: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    titleMedium: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    labelLarge: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily), // Buttons
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppConstants.primaryColor,
    titleTextStyle: TextStyle(
      fontFamily: AppConstants.fontFamily,
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppConstants.accentColor,
    foregroundColor: Colors.white,
  ),
);