import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';


ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding:  EdgeInsets.all(AppConstants.defaultPadding),
    backgroundColor: AppConstants.primaryColor,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 32),
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
    ),
  ),
);

OutlinedButtonThemeData outlinedButtonTheme(
    {Color? borderColor}) {
  borderColor ??= AppConstants.blackColor10;
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding:  EdgeInsets.all(AppConstants.defaultPadding),
      minimumSize: const Size(double.infinity, 32),
      side: BorderSide(width: 1.5, color: borderColor),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
      ),
    ),
  );
}

final textButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(foregroundColor: AppConstants.primaryColor),
);
