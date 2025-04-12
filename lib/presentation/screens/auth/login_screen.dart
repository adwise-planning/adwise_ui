
import 'package:adwise/core/constants/app_constants.dart';
import 'package:adwise/core/models/authentication.dart';
import 'package:adwise/core/services/auth_provider.dart';
import 'package:adwise/presentation/components/login_widget.dart';
import 'package:adwise/presentation/screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class LoginScreen extends ConsumerStatefulWidget {
  // Constructor for LoginScreen
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // Input fields for phone, email and password
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Authentication _user = Authentication();
  String _selectedCountryCode = '+1'; // Default country code
  bool _isPhoneLogin = true; // Toggle between phone & email login
  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  // Build method for LoginScreen widget. It returns a Scaffold with a SafeArea, SingleChildScrollView and Column. This is the main UI of the LoginScreen.
  @override
  Widget build(BuildContext context) {
    // Read the authProvider and authState from the provider scope. The authProvider is used to send OTP and login with email and password.
    ref.read(authProvider.notifier).setContext(context);
    final authState = ref.watch(authProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    //final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: AppConstants.primaryColor,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: Stack(
          children: [


            //Background Image
            SizedBox.expand(
              child: Image.asset(
                AppConstants.backgroundImagePath,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.5),
                //color: Colors.black,
                // colorBlendMode: BlendMode.difference,
                // colorBlendMode: BlendMode.luminosity,
                // color: Colors.purpleAccent, // Semi-transparent overlay
              ),
            ),
            // Main content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     
            Image.asset(
              "/images/login_dark.png",
              fit: BoxFit.cover,
            ),
                    // App Logo and Title
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              AppConstants.logo, // App logo
                              height: screenHeight * 0.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppConstants.welcomeMessage,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .white, // Ensure text remains readable
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Toggle between Phone & Email Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => setState(() => _isPhoneLogin = true),
                          child: Text(
                            'Login with Phone',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _isPhoneLogin
                                  ? AppConstants.primaryColor
                                  : Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('|',
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () =>
                              setState(() => _isPhoneLogin = false),
                          child: Text(
                            'Login with Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: !_isPhoneLogin
                                  ? AppConstants.primaryColor
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Form Fields
                    const SizedBox(height: 8),
                    Form(
                      key: _formKey,
                      child: LoginWidget(
                        isPhoneLogin: _isPhoneLogin,
                        phoneController: _phoneController,
                        emailController: _emailController,
                        selectedCountryCode: _selectedCountryCode,
                        countries: AppConstants.countries,
                        onCountryChanged: (newCode) =>
                            setState(() => _selectedCountryCode = newCode),
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Send OTP / Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authState.status == AuthStateStatus.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(authProvider.notifier)
                                      .clearError(); // Ensure authProvider has a method to reset errors
                                  if (_isPhoneLogin) {
                                    ref.read(authProvider.notifier).requestOTP(_isPhoneLogin, _emailController.text,
                                        _selectedCountryCode,
                                        _phoneController.text);
                                  } else {
                                    ref
                                        .read(authProvider.notifier)
                                        .loginWithEmail(_emailController.text,
                                            _passwordController.text);
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.accentColor,
                          // padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            //borderRadius: BorderRadius.circular(15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: authState.status == AuthStateStatus.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isPhoneLogin ? 'Send OTP' : 'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // user registration
                    const SizedBox(height: 16),
                    // Inside the "Don't have an account?" section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: authState.status == AuthStateStatus.loading
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                        countryCode: _selectedCountryCode,
                                        phoneNumber: _phoneController.text,
                                        email: _emailController.text,
                                      ),
                                    ),
                                  );
                                },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppConstants.accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
