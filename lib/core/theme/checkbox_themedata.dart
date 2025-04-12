import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';


CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: MaterialStateProperty.all(Colors.white),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(AppConstants.defaultBorderRadious / 2),
    ),
  ),
  side: BorderSide(color: AppConstants.whileColor40),
);
