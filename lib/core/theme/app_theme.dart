import 'package:Adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: AppConstants.primaryColor,
  colorScheme: ColorScheme.light(
    primary: AppConstants.primaryColor,
    secondary: AppConstants.accentColor,
  ),
  scaffoldBackgroundColor: Colors.white,
);

final darkTheme = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: AppConstants.primaryColor,
  colorScheme: ColorScheme.dark(
    primary: AppConstants.primaryColor,
    secondary: AppConstants.accentColor,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
);
