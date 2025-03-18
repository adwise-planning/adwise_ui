import 'package:flutter/material.dart';
import 'package:adwise/core/utils/validators.dart';
import 'package:flutter/services.dart';

class RegistrationWidget extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Future<bool> Function(String) checkEmailExists;
  final Future<bool> Function(String) checkPhoneExists;
  final bool isDarkMode;

  const RegistrationWidget({
    super.key,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.checkEmailExists,
    required this.checkPhoneExists,
    required this.isDarkMode,
  });

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  bool emailTouched = false;
  bool phoneTouched = false;
  bool passwordTouched = false;
  String? emailError;
  String? phoneError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildEmailField(),
        const SizedBox(height: 12),
        _buildPhoneField(),
        const SizedBox(height: 12),
        _buildPasswordField(),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
      style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: 'Email Address',
        prefixIcon: const Icon(Icons.email, color: Colors.blue),
        errorText: emailError,
      ),
      onChanged: (value) async {
        setState(() => emailTouched = true);
        Validators.emailValidator(value);
        // if (_is_valid_email) {
        //   setState(() => emailError = 'Invalid email');
        // } else {
        //   bool exists = await widget.checkEmailExists(value);
        //   setState(() => emailError = exists ? 'Email already in use' : null);
        // }
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: widget.phoneController,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: 'Phone Number',
        prefixIcon: const Icon(Icons.phone, color: Colors.blue),
        errorText: phoneError,
      ),
      onChanged: (value) async {
        setState(() => phoneTouched = true);
        // if (!Validators.isValidPhone(value)) {
        //   setState(() => phoneError = 'Invalid phone number');
        // } else {
        //   bool exists = await widget.checkPhoneExists(value);
        //   setState(() => phoneError = exists ? 'Phone number already in use' : null);
        // }
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: true,
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
      style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock, color: Colors.blue),
        errorText: passwordTouched ? Validators.passwordValidator(widget.passwordController.text) : null,
      ),
      onChanged: (value) {
        setState(() => passwordTouched = true);
      },
    );
  }
}
