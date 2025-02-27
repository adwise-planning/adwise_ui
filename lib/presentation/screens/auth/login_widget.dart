import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:Adwise/core/utils/validators.dart';
import 'package:Adwise/core/constants/app_constants.dart'; // Assuming you have your colors defined here

class LoginWidget extends StatefulWidget { // Changed to StatefulWidget to manage touched state
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
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool phoneTouched = false; // Track if phone field has been touched
  bool emailTouched = false; // Track if email field has been touched
  bool passwordTouched = false; // Track if password field has been touched

  @override
  Widget build(BuildContext context) {
    return Container( // Root Container for Background
      decoration: BoxDecoration(
        gradient: LinearGradient( // Background Gradient - Soft and subtle
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.isDarkMode ? AppConstants.primaryColorShade : Colors.white, // Dark mode starts darker
            widget.isDarkMode ? Colors.grey[900]! : Colors.grey[100]!, // Light mode fades to light grey
          ],
        ),
      ),
      padding: const EdgeInsets.all(20), // Padding around the login form
      child: AnimatedSwitcher( // Smooth transition between login types
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: widget.isPhoneLogin ? _buildPhoneLogin(context) : _buildEmailLogin(context),
      ),
    );
  }

  // Phone Number Input - Error Below Field, Conditionally Displayed
  Widget _buildPhoneLogin(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container( // Container for input field background
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.isDarkMode ? Colors.grey[800] : Colors.white, // White for light mode input
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: widget.selectedCountryCode,
                  dropdownColor: widget.isDarkMode ? Colors.grey[900] : Colors.white,
                  icon: const Icon(Icons.arrow_drop_down, color: AppConstants.primaryColor),
                  style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87, fontSize: 16),
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
                          CountryFlag.fromCountryCode(
                            country['flag']!,
                            width: 28,
                            height: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(country['code']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.phoneController,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey),
                    errorStyle: TextStyle(color: Colors.redAccent), // Error text style - Red accent
                  ),
                  onChanged: (value) { // Set phoneTouched when user starts typing
                    setState(() {
                      phoneTouched = true;
                    });
                  },
                  validator: (value) => phoneTouched ? Validators.phoneValidator(value) : null, // Validate only if touched
                ),
              ),
            ],
          ),
        ),
        // Error Message Area - Below Phone Input - Conditional Display
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 5.0), // Indented and spaced from input
          child:  Builder( // Using Builder to get context for Theme
              builder: (context) {
                final error = Validators.phoneValidator(widget.phoneController.text);
                return (phoneTouched && error != null) // Show error only if touched AND invalid
                    ? Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)) // Use theme error color
                    : const SizedBox.shrink(); // No error, no space
              },
            ),
        ),
      ],
    );
  }

  // Email & Password Input - Error Below Each Field - Conditional Display
  Widget _buildEmailLogin(BuildContext context) {
    return Container( // Container for Email/Password Form
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isDarkMode ? Colors.grey[800] : Colors.white, // White background for light mode form
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field with Error Below - Conditional Display
          TextFormField(
            controller: widget.emailController,
            autofillHints: const [AutofillHints.username],
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Email Address',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email, color: AppConstants.primaryColor),
              errorStyle: TextStyle(color: Colors.redAccent), // Error text style - Red accent
            ),
             onChanged: (value) { // Set emailTouched when user starts typing
              setState(() {
                emailTouched = true;
              });
            },
            validator: (value) => emailTouched ? Validators.emailValidator(value) : null, // Validate only if touched
          ),
          Padding( // Error message for Email - Conditional Display
            padding: const EdgeInsets.only(left: 12.0, bottom: 8.0), // Indented and spaced
            child: Builder( // Using Builder to get context for Theme
              builder: (context) {
                final error = Validators.emailValidator(widget.emailController.text);
                return (emailTouched && error != null) // Show error only if touched AND invalid
                    ? Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)) // Use theme error color
                    : const SizedBox.shrink();
              },
            ),
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),

          // Password Field with Error Below - Conditional Display
          TextFormField(
            controller: widget.passwordController,
            autofillHints: const [AutofillHints.password],
            obscureText: true,
            style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.lock, color: AppConstants.primaryColor),
              errorStyle: TextStyle(color: Colors.redAccent), // Error text style - Red accent
            ),
             onChanged: (value) { // Set passwordTouched when user starts typing
              setState(() {
                passwordTouched = true;
              });
            },
            validator: (value) => passwordTouched ? Validators.passwordValidator(value) : null, // Validate only if touched
          ),
          Padding( // Error message for Password - Conditional Display
            padding: const EdgeInsets.only(left: 12.0, top: 5.0), // Indented and spaced
            child: Builder( // Using Builder to get context for Theme
              builder: (context) {
                final error = Validators.passwordValidator(widget.passwordController.text);
                return (passwordTouched && error != null) // Show error only if touched AND invalid
                    ? Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12)) // Use theme error color
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}