import 'package:Adwise/core/constants/app_constants.dart';
import 'package:Adwise/core/utils/validators.dart';
import 'package:Adwise/domain/providers/auth_provider.dart';
import 'package:Adwise/presentation/screens/auth/login_widget.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedCountryCode = '+1'; // Default country code
  bool _isPhoneLogin = true; // Toggle between phone & email login
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(authProvider.notifier).setContext(context);
    final authState = ref.watch(authProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //   return Scaffold(
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Logo and Title
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'logo.png',
                          height: screenHeight * 0.2,
                        ),
                      ),
                      // Icon(
                      //   Icons.chat_bubble_outline,
                      //   size: 100,
                      //   color: isDarkMode
                      //       ? Colors.white
                      //       : AppConstants.primaryColor,
                      // ),
                      const SizedBox(height: 16),
                      Text(
                        AppConstants.welcomeMessage,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? Colors.white
                                  : AppConstants.primaryColor,
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
                              : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('|',
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () => setState(() => _isPhoneLogin = false),
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
                const SizedBox(height: 20),

                // Phone Number Input
                // Text(
                //  'Enter your phone number',
                //  style: Theme.of(context).textTheme.titleMedium,
                // ),
                const SizedBox(height: 8),
                Form(
                  key: _formKey,
                  child: LoginWidget(
                    isPhoneLogin: _isPhoneLogin,
                    phoneController: _phoneController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    selectedCountryCode: _selectedCountryCode,
                    countries: AppConstants.countries,
                    onCountryChanged: (newCode) =>
                        setState(() => _selectedCountryCode = newCode),
                    isDarkMode: isDarkMode,
                  ),

                  // child: _isPhoneLogin
                  //     ? _buildPhoneLogin(isDarkMode)
                  //     : _buildEmailLogin(isDarkMode),
                  //  child: TextFormField(
                  //    controller: _phoneController,
                  //    keyboardType: TextInputType.phone,
                  //    textInputAction: TextInputAction.done,
                  //    decoration: InputDecoration(
                  //      hintText: 'e.g., +1 234 567 890',
                  //      prefixIcon: const Icon(Icons.phone),
                  //      border: OutlineInputBorder(
                  //        borderRadius: BorderRadius.circular(12),
                  //      ),
                  //      filled: true,
                  //      // fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  //      fillColor: Theme.of(context)
                  //              .inputDecorationTheme
                  //              .fillColor ??
                  //          (isDarkMode ? Colors.grey[800] : Colors.grey[200]),
                  //    ),
                  //    validator: Validators.phoneValidator,
                  //  ),
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
                              // ref.read(authProvider.notifier).sendOTP(_phoneController.text);
                              if (_isPhoneLogin) {
                                String fullPhoneNumber =
                                    '$_selectedCountryCode ${_phoneController.text}';
                                ref
                                    .read(authProvider.notifier)
                                    .sendOTP(fullPhoneNumber);
                              } else {
                                ref
                                    .read(authProvider.notifier)
                                    .loginWithEmail(_emailController.text);
                              }
                              // ref
                              //    .read(authProvider.notifier)
                              //    .sendOTP(_phoneController.text);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
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
                        // : const Text(
                        //    'Send OTP',
                        //    style: TextStyle(fontSize: 16),
                        : Text(
                            _isPhoneLogin ? 'Send OTP' : 'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? AppConstants.primaryColor
                                  : Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Error Message
                if (authState.error != null)
                  Center(
                    child: Text(
                      authState.error!,
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 14,
                      ),
                    ),
                  ),

                // Success Message
                if (authState.status == AuthStateStatus.success)
                  Center(
                    child: Text(
                      // 'OTP Sent Successfully!',
                      _isPhoneLogin
                          ? 'OTP Sent Successfully!'
                          : 'Login Successful!',
                      style: TextStyle(
                        color: Colors.green[400],
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Phone Input Field (with integrated Country Code dropdown)
  // Widget _buildPhoneLogin(bool isDarkMode) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       InputDecorator(
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           filled: true,
  //           fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
  //         ),
  //         child: Row(
  //           children: [
  //             // Country Code Dropdown
  //             DropdownButtonHideUnderline(
  //               child: DropdownButton<String>(
  //                 value: _selectedCountryCode,
  //                 onChanged: (String? newValue) {
  //                   if (newValue != null) {
  //                     setState(() => _selectedCountryCode = newValue);
  //                   }
  //                 },
  //                 items: _countries.map((country) {
  //                   return DropdownMenuItem<String>(
  //                     value: country['code'],
  //                     child: Row(
  //                       children: [
  //                         CountryFlag.fromCountryCode(
  //                           country['flag']!,
  //                           width: 24,
  //                           height: 16,
  //                         ),
  //                         const SizedBox(width: 8),
  //                         Text(country['code']!),
  //                       ],
  //                     ),
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //             const SizedBox(width: 8),

  //             // Phone Number Input
  //             Expanded(
  //               child: TextFormField(
  //                 controller: _phoneController,
  //                 keyboardType: TextInputType.phone,
  //                 decoration: const InputDecoration(
  //                   border: InputBorder.none,
  //                   hintText: 'Enter phone number',
  //                 ),
  //                 validator: (value) => Validators.phoneValidator(value),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // // Email & Password Input
  // Widget _buildEmailLogin(bool isDarkMode) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
  //           borderRadius: BorderRadius.circular(12),
  //           border: Border.all(color: Colors.grey),
  //         ),
  //         child: Column(
  //           children: [
  //             // Email Field
  //             TextFormField(
  //               controller: _emailController,
  //               keyboardType: TextInputType.emailAddress,
  //               decoration: const InputDecoration(
  //                 border: InputBorder.none,
  //                 hintText: 'Email Address',
  //                 prefixIcon: Icon(Icons.email),
  //               ),
  //               validator: (value) => Validators.emailValidator(value),
  //             ),
  //             Divider(color: Colors.grey[400]),

  //             // Password Field
  //             TextFormField(
  //               controller: _passwordController,
  //               obscureText: true,
  //               decoration: const InputDecoration(
  //                 border: InputBorder.none,
  //                 hintText: 'Password',
  //                 prefixIcon: Icon(Icons.lock),
  //               ),
  //               validator: (value) => Validators.passwordValidator(value),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
