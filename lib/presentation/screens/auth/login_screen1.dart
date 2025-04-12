import 'package:adwise/core/constants/app_constants.dart';
import 'package:adwise/core/services/auth_provider.dart';
import 'package:adwise/presentation/components/login_widget.dart';
import 'package:adwise/presentation/screens/auth/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedCountryCode = '+1'; // Default country code

  bool isDarkMode = false; // Change this based on your app's theme
  bool _isPhoneLogin = true; // Toggle between phone & email login

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ref.read(authProvider.notifier).setContext(context);
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // STACKED IMAGES
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              AppConstants.backgroundImagePath,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Image.asset(
                            AppConstants.logo,
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),

                    // LOGIN FORM SECTION
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.all(AppConstants.defaultPadding * 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.loginHeading,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SizedBox(height: AppConstants.defaultPadding / 2),
                            Text(
                              AppConstants.loginSubHeading,
                              style: TextStyle(
                                color: AppConstants.greyColor,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: AppConstants.defaultPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      setState(() => _isPhoneLogin = true),
                                  child: Text(
                                    'Login with Phone',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _isPhoneLogin
                                          ? AppConstants.primaryColor
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text('|',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey)),
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
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppConstants.defaultPadding),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Form(
                                child: LoginWidget(
                                  isPhoneLogin: _isPhoneLogin,
                                  phoneController: _phoneController,
                                  emailController: _emailController,
                                  selectedCountryCode: _selectedCountryCode,
                                  countries: AppConstants.countries,
                                  onCountryChanged: (newCode) => setState(
                                      () => _selectedCountryCode = newCode),
                                  isDarkMode: false,
                                ),
                              ),
                            ),
                            SizedBox(height: AppConstants.defaultPadding),
                            ElevatedButton(
                              onPressed:
                                  authState.status == AuthStateStatus.loading
                                      ? null
                                      : () {
                                          ref
                                              .read(authProvider.notifier)
                                              .clearError(); // Ensure authProvider has a method to reset errors
                                          ref
                                              .read(authProvider.notifier)
                                              .requestOTP(
                                                  _isPhoneLogin,
                                                  _emailController.text,
                                                  _selectedCountryCode,
                                                  _phoneController.text);
                                        },

                              // child: const Text("Log in"),

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
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  // onPressed: () {
                                  //   Navigator.pushNamed(context, signUpScreenRoute);
                                  // },
                                  onPressed: authState.status ==
                                          AuthStateStatus.loading
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrationScreen(
                                                countryCode:
                                                    _selectedCountryCode,
                                                phoneNumber:
                                                    _phoneController.text,
                                                email: _emailController.text,
                                              ),
                                            ),
                                          );
                                        },
                                  child: const Text("Sign up"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: AppConstants.defaultPadding *
                            (_isPhoneLogin ? 0.5 : 0.45)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
