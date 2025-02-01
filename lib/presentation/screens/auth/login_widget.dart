import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:Adwise/core/utils/validators.dart';

class LoginWidget extends StatelessWidget {
  final bool isPhoneLogin;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String selectedCountryCode;
  final List<Map<String, String>> countries;
  final Function(String) onCountryChanged;
  final bool isDarkMode;

  const LoginWidget({
    super.key,
    required this.isPhoneLogin,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.selectedCountryCode,
    required this.countries,
    required this.onCountryChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return isPhoneLogin ? _buildPhoneLogin() : _buildEmailLogin();
  }

  // Phone Number Input
  Widget _buildPhoneLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          ),
          child: Row(
            children: [
              // Country Code Dropdown
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCountryCode,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onCountryChanged(newValue);
                    }
                  },
                  items: countries.map((country) {
                    return DropdownMenuItem<String>(
                      value: country['code'],
                      child: Row(
                        children: [
                          CountryFlag.fromCountryCode(
                            country['flag']!,
                            width: 24,
                            height: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(country['code']!),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 8),

              // Phone Number Input
              Expanded(
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter phone number',
                  ),
                  validator: (value) => Validators.phoneValidator(value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Email & Password Input
  Widget _buildEmailLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            children: [
              // Email Field
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) => Validators.emailValidator(value),
              ),
              Divider(color: Colors.grey[400]),

              // Password Field
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) => Validators.passwordValidator(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
