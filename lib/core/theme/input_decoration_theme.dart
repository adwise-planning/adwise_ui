import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';


InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  fillColor: AppConstants.lightGreyColor,
  filled: true,
  hintStyle: TextStyle(color: AppConstants.greyColor),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  fillColor: AppConstants.darkGreyColor,
  filled: true,
  hintStyle: TextStyle(color: AppConstants.whileColor40),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
);

OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
  borderSide: BorderSide(color: AppConstants.primaryColor),
);

OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
  borderSide: BorderSide(
    color: AppConstants.errorColor,
  ),
);

OutlineInputBorder secodaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadious)),
    borderSide: BorderSide(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.15),
    ),
  );
  
}
