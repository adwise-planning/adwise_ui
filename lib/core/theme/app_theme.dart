import 'package:adwise/core/constants/app_constants.dart';
import 'package:adwise/core/theme/button_theme.dart';
import 'package:adwise/core/theme/checkbox_themedata.dart';
import 'package:adwise/core/theme/input_decoration_theme.dart';
import 'package:adwise/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scrollbarTheme: scrollbarThemeData,
  dataTableTheme: dataTableLightThemeData,

  elevatedButtonTheme: elevatedButtonThemeData,
  textButtonTheme: textButtonThemeData,
  outlinedButtonTheme: outlinedButtonTheme(),
  inputDecorationTheme: lightInputDecorationTheme,
  checkboxTheme: checkboxThemeData.copyWith(
    side: BorderSide(color: AppConstants.blackColor40),
  ),

  brightness: Brightness.light,
  primarySwatch: AppConstants.primaryMaterialColor,

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
  brightness: Brightness.dark,
  fontFamily: AppConstants.fontFamily,
  primaryColor: AppConstants.primaryColor,
  primarySwatch: AppConstants.primaryMaterialColor,
  scaffoldBackgroundColor: Colors.grey[900],
  
  // Colors & Scheme
  colorScheme: ColorScheme.dark(
    primary: AppConstants.primaryColor,
    secondary: AppConstants.accentColor,
    surface: Colors.grey[900]!,
    background: Colors.grey[900]!,
    error: Colors.redAccent,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
  ),

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: AppConstants.primaryColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: AppConstants.fontFamily,
    ),
  ),

  // FAB
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppConstants.accentColor,
    foregroundColor: Colors.white,
  ),

  // Texts
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    bodyMedium: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    titleLarge: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    titleMedium: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
    labelLarge: TextStyle(color: Colors.white, fontFamily: AppConstants.fontFamily),
  ),

  // Form / Inputs
  inputDecorationTheme: lightInputDecorationTheme,

  // Buttons
  elevatedButtonTheme: elevatedButtonThemeData,
  textButtonTheme: textButtonThemeData,
  outlinedButtonTheme: outlinedButtonTheme(),

  // Checkbox
  checkboxTheme: checkboxThemeData.copyWith(
    side: BorderSide(color: AppConstants.blackColor40),
  ),

  // Tables
  dataTableTheme: dataTableLightThemeData,

  // Scrollbar
  scrollbarTheme: scrollbarThemeData,
);
