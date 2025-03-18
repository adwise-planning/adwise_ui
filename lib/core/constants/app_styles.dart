import 'package:flutter/material.dart';
import 'app_constants.dart';

BoxDecoration inputFieldDecoration(bool isDarkMode) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: isDarkMode ? Colors.grey[800] : Colors.white,
          border: Border(
            top: BorderSide(
                color: AppConstants.primaryColor,
                width: 2), // Top border - Primary color
            bottom: BorderSide(
                color: AppConstants.primaryColor,
                width: 2), // Bottom border - Primary color
            right: BorderSide(
                color: AppConstants.primaryColor,
                width: 2), // Top border - Primary color
            left: BorderSide(
                color: AppConstants.primaryColor,
                width: 2), // Top border - Primary color
  ));
}