import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:adwise/core/utils/validators.dart';
import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart'; // Assuming you have your colors defined here

class LoginWidget extends StatefulWidget {
  // Changed to StatefulWidget to manage touched state
  final bool isPhoneLogin;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String selectedCountryCode;
  final List<Map<String, String>> countries;
  final Function(String) onCountryChanged;
  final bool isDarkMode;

  const LoginWidget({
    super.key,
    required this.isPhoneLogin,
    required this.phoneController,
    required this.emailController,
    required this.selectedCountryCode,
    required this.countries,
    required this.onCountryChanged,
    required this.isDarkMode,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool phoneTouched = false; // Track if phone field has been touched
  bool emailTouched = false; // Track if email field has been touched
  bool passwordTouched = false; // Track if password field has been touched
  bool hasError = false; // Track if any field has an error

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 0), // Padding around the login form
      child: AnimatedSwitcher(
        // Smooth transition between login types
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: widget.isPhoneLogin
            ? _buildPhoneLogin(context)
            : _buildEmailLogin(context),
      ),
    );
  }

  // Phone Number Input - Error Below Field, Conditionally Displayed
  Widget _buildPhoneLogin(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.selectedCountryCode,
                borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadious),
                menuWidth: 100,
                dropdownColor: widget.isDarkMode
                    ? AppConstants.textDark
                    : AppConstants.textLight,
                icon: Icon(Icons.arrow_drop_down,
                    color: widget.isDarkMode
                        ? AppConstants.textLight
                        : AppConstants.textDark),
                style: TextStyle(
                  color: widget.isDarkMode
                      ? AppConstants.textLight
                      : AppConstants.textDark,
                  // fontWeight: FontWeight.w500,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    widget.onCountryChanged(newValue);
                  }
                },
                items: widget.countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['code'],
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        CountryFlag.fromCountryCode(
                          country['flag']!,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(country['code']!)
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // SizedBox(width: 10),

            Expanded(
              child: TextFormField(
                cursorColor: widget.isDarkMode
                    ? AppConstants.textLight
                    : AppConstants.textDark,
                controller: widget.phoneController,
                autofillHints: const [AutofillHints.telephoneNumber],
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter
                      .singleLineFormatter, // Allows only single line
                ],
                style: TextStyle(
                  color: widget.isDarkMode
                      ? AppConstants.textLight
                      : AppConstants.textDark,
                ),
                validator: Validators.phoneValidator.call,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  fillColor: widget.isDarkMode
                      ? AppConstants.textDark
                      : AppConstants.textLight,
                  filled: true,
                  hintText: "Phone Number",
                  // prefixIcon: Padding(
                  //     padding:
                  //         const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
                  //     child: Icon(
                  //         PhosphorIcons.deviceMobileCamera(
                  //             PhosphorIconsStyle.regular),
                  //         color: widget.isDarkMode
                  //             ? AppConstants.textLight
                  //             : AppConstants.textDark)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Email & Password Input - Error Below Each Field - Conditional Display
  Widget _buildEmailLogin(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          cursorColor: widget.isDarkMode
              ? AppConstants.textLight
              : AppConstants.textDark,
          controller: widget.emailController,
          autofillHints: const [AutofillHints.username],
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter
                .singleLineFormatter, // Allows only single line
          ],
          style: TextStyle(
            color: widget.isDarkMode
                ? AppConstants.textLight
                : AppConstants.textDark,
          ),
          validator: emaildValidator.call,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: widget.isDarkMode
                ? AppConstants.textDark
                : AppConstants.textLight,
            filled: true,
            hintText: "Email address",
            prefixIcon: Padding(
                padding:
                     EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                child: Icon(
                    PhosphorIcons.envelopeSimpleOpen(
                        PhosphorIconsStyle.regular),
                    color: widget.isDarkMode
                        ? AppConstants.textLight
                        : AppConstants.textDark)),
          ),
        ),
      ],
    );
  }
}
