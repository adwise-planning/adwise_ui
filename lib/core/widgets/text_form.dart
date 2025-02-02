import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  final bool isDarkMode;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        // ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}