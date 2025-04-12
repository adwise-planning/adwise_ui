import 'package:adwise/core/services/auth_provider.dart';
import 'package:adwise/core/theme/app_elements.dart';
import 'package:adwise/core/utils/validators.dart';
import 'package:adwise/presentation/screens/auth/otp_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  final String countryCode;
  final String phoneNumber;
  final String email;

  const RegistrationScreen({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
  });

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedCountryCode = "+1"; // Default country code
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    // Only set initial values once here
    // _formKey = widget.formKey;
    _selectedCountryCode = widget.countryCode;
    _phoneController.text = widget.phoneNumber;
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppConstants.backgroundImagePath,
              fit: BoxFit.cover,
              opacity: AlwaysStoppedAnimation(0.5),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(theme, isDarkMode),
                    _buildEmailField(theme, isDarkMode),
                    _buildPhoneField(theme, isDarkMode),
                    _buildPasswordField(theme, isDarkMode),
                    _buildConfirmPasswordField(theme, isDarkMode),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: authState.status == AuthStateStatus.loading
                          ? null
                          : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(ThemeData theme, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
          controller: _fullNameController,
          keyboardType: TextInputType.name,
          inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
          decoration: appInputDecoration(
              theme: theme,
              isDarkMode: isDarkMode,
              hintText: "Full Name",
              prefixIcon: Icons.perm_identity
              // labelText: label,
              ),
          validator: (value) =>
              value == null || value.isEmpty || value.length < 4
                  ? 'Please enter your Full Name'
                  : null,
          onChanged: (_) => _formKey.currentState?.validate(),
      )
    );
  }

  Widget _buildEmailField(ThemeData theme, bool isDarkMode) {
    return  TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        decoration: appInputDecoration(
          theme: theme,
          isDarkMode: isDarkMode,
          hintText: 'Email',
          prefixIcon: Icons.alternate_email,
        ),
        validator: Validators.emailValidator,
        onChanged: (_) => _formKey.currentState?.validate(),
    );
  }

  // Builds the Phone Input Row using country_code_picker
  Widget _buildPhoneField(ThemeData theme, bool isDarkMode) {
    final backgroundColor = isDarkMode ? AppConstants.dark : AppConstants.light;
    final pickerDialogBgColor =
        isDarkMode ? AppConstants.dark : AppConstants.light;
    final pickerTextColor =
        isDarkMode ? AppConstants.textLight : AppConstants.textDark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Country Code Picker ---
          CountryCodePicker(
            onChanged: (countryCode) {
              if (countryCode.dialCode != null) {
                setState(() {
                  // Store the dial code (e.g., "+1")
                  _selectedCountryCode = countryCode.dialCode!;
                });
              }
            },
            initialSelection:
                'US', // Or infer from _selectedCountryCode if needed
            favorite: const ['+1', '+91'], // Common countries

            builder: (CountryCode? country) {
              return Container(
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppConstants.textLight.withOpacity(0.1)
                      : AppConstants.textDark
                          .withOpacity(0.1), // Background color for the picker
                  borderRadius: BorderRadius.circular(12), // Rounded edges
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (country != null) ...[
                      Image.asset(
                        country.flagUri!,
                        package: 'country_code_picker',
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        country.dialCode ?? '',
                        style: appTextStyle(isDarkMode: isDarkMode),
                      ),
                    ],
                  ],
                ),
              );
            },

            // Styling
            backgroundColor:
                backgroundColor, // Background of the picker widget itself
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 12), // Adjust padding
            textStyle:
                appTextStyle(isDarkMode: isDarkMode), // Selected code text
            flagWidth: 24,

            boxDecoration: BoxDecoration(
              // Styling for the picker widget itself
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            // Dialog Styling
            dialogBackgroundColor: pickerDialogBgColor,
            dialogTextStyle: appTextStyle(isDarkMode: isDarkMode),

            searchStyle:
                appTextStyle(isDarkMode: isDarkMode), // Search text color
            searchDecoration: appInputDecoration(
              theme: theme,
              isDarkMode: isDarkMode,
              hintText: "Search Country/Code",
              prefixIcon: Icons.search,
            ),
            // Hide the widget's default underline
            showFlagDialog: true, // Use the dialog
            barrierColor: isDarkMode
                ? AppConstants.textLight.withOpacity(0.5)
                : AppConstants.textDark
                    .withOpacity(0.5), // Dim background when dialog is open
            closeIcon: Icon(Icons.close, color: pickerTextColor),
          ),
          const SizedBox(width: 8),

          // --- Phone Number Field ---
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.singleLineFormatter
              ],
              style: appTextStyle(isDarkMode: isDarkMode),
              validator: Validators.phoneValidator, // Use your validator
              onChanged: (_) => _formKey.currentState?.validate(),
              decoration: appInputDecoration(
                theme: theme,
                isDarkMode: isDarkMode,
                hintText: 'Phone Number',
                prefixIcon: Icons.phone, // Standard phone icon
                // prefixIcon: PhosphorIcons.deviceMobileCamera(PhosphorIconsStyle.regular), // Optional icon
              ),
              // Optional: Provide semantic label for accessibility
              // semanticsLabel: "Phone number input field",
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPhoneField(ThemeData theme, bool isDarkMode) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0), // Match other fields
  //     child: Container(
  //       width: double.infinity,
  //       padding: const EdgeInsets.symmetric(
  //           horizontal: 12.0, vertical: 0), // Consistent height
  //       child: Row(
  //         children: [
  //           DropdownButtonHideUnderline(
  //             child: DropdownButton<String>(
  //               value: _selectedCountryCode,
  //               icon: Icon(Icons.arrow_drop_down,
  //                   color: AppConstants.primaryColor),
  //               style: const TextStyle(fontSize: 16),
  //               items: AppConstants.countries.map((country) {
  //                 return DropdownMenuItem<String>(
  //                   value: country['code'],
  //                   child: Row(
  //                     children: [
  //                       CountryFlag.fromCountryCode(
  //                         country['flag']!,
  //                         width: 24,
  //                         height: 16,
  //                       ),
  //                       const SizedBox(width: 10),
  //                       Text(
  //                         country['code']!,
  //                         style: const TextStyle(fontWeight: FontWeight.w500),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }).toList(),
  //               onChanged: (newValue) {
  //                 setState(() {
  //                   _selectedCountryCode = newValue!;
  //                 });
  //               },
  //             ),
  //           ),
  //           const SizedBox(width: 10),
  //           Expanded(
  //             child: TextFormField(
  //               controller: _phoneController,
  //               autofillHints: const [AutofillHints.telephoneNumber],
  //               keyboardType: TextInputType.phone,
  //               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //               decoration: appInputDecoration(
  //                 theme: theme,
  //                 isDarkMode: isDarkMode,
  //                 prefixIcon: Icons.phone,
  //                 hintText: 'Phone Number',
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPasswordField(ThemeData theme, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        keyboardType: TextInputType.visiblePassword,
        decoration: appInputDecoration(
            theme: theme,
            isDarkMode: isDarkMode,
            hintText: 'Password',
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0),
              child: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: isDarkMode
                      ? AppConstants.textLight.withOpacity(0.5)
                      : AppConstants.textDark.withOpacity(0.5),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
        onChanged: (_) => _formKey.currentState?.validate(),
      ),
    );
  }

  Widget _buildConfirmPasswordField(ThemeData theme, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword, // Toggle visibility
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        keyboardType: TextInputType.visiblePassword,

        decoration: appInputDecoration(
            theme: theme,
            isDarkMode: isDarkMode,
            hintText: 'Confirm Password',
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0),
              child: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: isDarkMode
                      ? AppConstants.textLight.withOpacity(0.5)
                      : AppConstants.textDark.withOpacity(0.5),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          }
          if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        onChanged: (_) => _formKey.currentState?.validate(),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("User Registered: $_selectedCountryCode${_phoneController.text}");
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
                countryCode: _selectedCountryCode,
                phoneNumber: _phoneController.text,),
          ),
        );
      }
    }
  }
}
