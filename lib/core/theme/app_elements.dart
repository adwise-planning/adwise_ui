

import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

TextStyle appTextStyle ({
    required bool isDarkMode,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight,
      color: color ?? (isDarkMode ? AppConstants.textLight : AppConstants.textDark),
    );
  }

  // Helper for consistent InputDecoration

BoxDecoration appInputBoxDecoration(bool isDarkMode) {
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




InputDecoration appInputDecoration ({
    required ThemeData theme,
    required bool isDarkMode,
    required String hintText,
    bool? isRequired,
    String? labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    final hintColor = isDarkMode
        ? AppConstants.textLight.withOpacity(0.5)
        : AppConstants.textDark.withOpacity(0.5);
    final prefixIconColor =
        isDarkMode ? AppConstants.textLight : AppConstants.textDark;
    final fillColor = isDarkMode
        ? AppConstants.textLight.withOpacity(0.1)
        : AppConstants.textDark.withOpacity(0.1);
    final focusedBorderColor = AppConstants.primaryColor; // Your primary color
    // Use theme's error color for consistency
    final errorColor = theme.colorScheme.error;

    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(color: hintColor),
      prefixIconColor: hintColor.withOpacity(0.7),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0),
              child: Icon(prefixIcon, color: prefixIconColor, size: 20),
            )
          : null,
      // Adjust constraints to prevent excessive padding for prefix
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor,
      // Border styling
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // No border by default
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color: focusedBorderColor, width: 1.5), // Highlight on focus
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor, width: 1.5), // Error border
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor, width: 1.5),
      ),
      // Style for the validation error message
      errorStyle: TextStyle(
        color: errorColor.withOpacity(0.95), // Make error text clearly visible
        fontSize: 12,
        fontWeight: FontWeight.w500, // Slightly bolder error text
      ),
      // Padding within the input field
      contentPadding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: prefixIcon == null
            ? 16
            : 0, // Less horizontal padding if there's a prefix icon
      ),
    );
  }
