
import 'package:adwise/core/theme/app_elements.dart';
import 'package:adwise/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:country_code_picker/country_code_picker.dart';

// --- Assuming these imports exist based on your code ---
import 'package:adwise/core/constants/app_constants.dart'; // Your constants
import 'package:adwise/core/services/auth_provider.dart'; // Your Riverpod auth provider
import 'package:adwise/presentation/screens/auth/registration_screen.dart';
// import 'package:adwise/core/utils/validators.dart'; // Assuming your validators are here
// import 'package:phosphor_flutter/phosphor_flutter.dart'; // Optional icons

// --- Placeholder Constants & Validators (Replace with your actual ones) ---
const double defaultPadding = 16.0;
const Color greyColor = Colors.grey;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with RestorationMixin {
  // Controllers
  final RestorableTextEditingController _phoneController =
      RestorableTextEditingController();
  final RestorableTextEditingController _emailController =
      RestorableTextEditingController();
  // No password controller needed for OTP flow

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // State Variables
  String _selectedCountryCode = '+1'; // Default country dial code
  bool _isPhoneLogin = true; // Toggle between phone & email login

  // --- Restoration ---
  @override
  String? get restorationId => 'login_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_phoneController, 'phone_controller');
    registerForRestoration(_emailController, 'email_controller');
    // Could restore _isPhoneLogin and _selectedCountryCode if needed via RestorableProperty
  }
  // --- End Restoration ---

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // --- OTP Request Logic ---
  Future<void> _handleOtpRequest() async {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      final authNotifier = ref.read(authProvider.notifier);
      // Optional: Clear previous errors if your provider has such a method
      // authNotifier.clearError();

      if (_isPhoneLogin) {
        // Use the phone number and country code
        // Ensure dial code has '+' if backend expects it
        String dialCode = _selectedCountryCode.startsWith('+')
            ? _selectedCountryCode
            : '+$_selectedCountryCode';
        print(
            'Requesting OTP for Phone: $dialCode${_phoneController.value.text}');
        // !!! Replace with your actual provider call !!!
        // authNotifier.requestPhoneOtp(dialCode, _phoneController.value.text);
      } else {
        // Use the email address
        print('Requesting OTP for Email: ${_emailController.value.text}');
        // !!! Replace with your actual provider call !!!
        // authNotifier.requestEmailOtp(_emailController.value.text);
      }
      // Navigation to OTP screen should be handled by the authProvider upon success
    } else {
      // Show a generic error message if validation fails (fields should show specific errors)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please check the input fields.'),
          backgroundColor: AppConstants.warningColor,
          duration: const Duration(seconds: 2),
        ),
      );
      print('Validation failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Watch the auth provider state
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStateStatus.loading;

    // Set context in provider if needed (consider alternatives)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Consider passing context directly when calling provider methods if needed instead
        // ref.read(authProvider.notifier).setContext(context);
      }
    });

    return Theme(
        data: theme,
        child: Scaffold(
          // Prevent resize when keyboard appears, rely on SingleChildScrollView
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              // --- Main Scrollable Content ---
              SafeArea(
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    // padding: EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: constraints
                              .maxHeight), // Ensure it takes at least screen height
                      child: IntrinsicHeight(
                        // Ensure Column children can expand correctly
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.40,
                              width: double.infinity,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      isDarkMode
                                          ? AppConstants.darkBackgroundImage
                                          : AppConstants.lightBackgroundImage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Image.asset(
                                    AppConstants.logo,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(
                                    AppConstants.defaultPadding * 3),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // --- Middle Section (Form Area) ---
                                      Text(
                                        AppConstants.loginHeading,
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                                color: isDarkMode
                                                    ? AppConstants.textLight
                                                    : AppConstants.textDark,
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                          height: defaultPadding / 2),
                                      Text(
                                        AppConstants.loginSubHeading,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                                color: isDarkMode
                                                    ? AppConstants.textLight
                                                    : AppConstants.textDark),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 1.5),

                                      // --- Login Type Switcher ---
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _buildLoginTypeButton(
                                              context,
                                              'Login with Phone',
                                              isDarkMode,
                                              _isPhoneLogin, () {
                                            if (!_isPhoneLogin) {
                                              setState(
                                                  () => _isPhoneLogin = true);
                                              _formKey.currentState
                                                  ?.reset(); // Reset validation state on switch
                                              _emailController.value
                                                  .clear(); // Clear inactive field
                                            }
                                          }),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text('|',
                                                style: appTextStyle(
                                                  isDarkMode: isDarkMode,
                                                  fontSize: 18,
                                                )),
                                          ),
                                          _buildLoginTypeButton(
                                              context,
                                              'Login with Email',
                                              isDarkMode,
                                              !_isPhoneLogin, () {
                                            if (_isPhoneLogin) {
                                              setState(
                                                  () => _isPhoneLogin = false);
                                              _formKey.currentState
                                                  ?.reset(); // Reset validation state on switch
                                              _phoneController.value
                                                  .clear(); // Clear inactive field
                                            }
                                          }),
                                        ],
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 0.5),

                                      // --- Form ---
                                      Form(
                                        key: _formKey,
                                        // Validate fields immediately after user interaction
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          transitionBuilder:
                                              (child, animation) {
                                            return FadeTransition(
                                                opacity: animation,
                                                child: child);
                                          },
                                          // Use KeyedSubtree or ValueKey to help AnimatedSwitcher differentiate
                                          child: _isPhoneLogin
                                              ? KeyedSubtree(
                                                  key: const ValueKey(
                                                      'phone_input'),
                                                  child: _buildPhoneInput(
                                                      theme, isDarkMode))
                                              : KeyedSubtree(
                                                  key: const ValueKey(
                                                      'email_input'),
                                                  child: _buildEmailInput(
                                                      theme, isDarkMode)),
                                        ),
                                      ),

                                      // No "Forgot Password" needed for OTP flow

                                      // Use Spacer to push remaining content to the bottom
                                      const Spacer(),
                                      // --- Bottom Section ---
                                      // --- Action Button ---
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: defaultPadding),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            backgroundColor: AppConstants
                                                .primaryColor, // Use your primary color
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: isLoading
                                              ? null
                                              : _handleOtpRequest,
                                          child: isLoading
                                              ? const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 3,
                                                  ),
                                                )
                                              : Text(
                                                  // Both methods now request OTP
                                                  'Send OTP',
                                                  style: appTextStyle(
                                                      isDarkMode: true,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: defaultPadding * 0.5),

                                      ColoredBox(
                                        color: Colors.red,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: double.infinity,
                                        ), // Bottom padding
                                      ),
                                      // --- Sign Up Navigation ---
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Don't have an account?",
                                              style: appTextStyle(
                                                  isDarkMode: isDarkMode)),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              visualDensity:
                                                  VisualDensity.compact,
                                              foregroundColor: AppConstants
                                                  .primaryColor, // Use your primary color
                                            ),
                                            onPressed: isLoading
                                                ? null
                                                : () {
                                                    // Navigate to Registration Screen
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrationScreen(
                                                          // Pass initial data if needed, otherwise pass defaults/empty
                                                          // Ensure RegistrationScreen constructor is updated if needed
                                                          countryCode:
                                                              _selectedCountryCode,
                                                          phoneNumber:
                                                              _phoneController
                                                                  .value.text,
                                                          email:
                                                              _emailController
                                                                  .value.text,
                                                        ),
                                                      ),
                                                    );
                                                    // Or use named route: Navigator.pushNamed(context, signUpScreenRoute);
                                                  },
                                            child: Text("Sign up",
                                                style: appTextStyle(
                                                    isDarkMode: isDarkMode,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                          height:
                                              defaultPadding), // Bottom padding
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  // --- Helper Widget Builders ---

  // Builds the Phone/Email toggle buttons
  Widget _buildLoginTypeButton(BuildContext context, String label,
      bool isDarkMode, bool isActive, VoidCallback onPressed) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all(Colors.transparent), // No hover/ripple
        backgroundColor:
            MaterialStateProperty.all(Colors.transparent), // Always transparent
        foregroundColor: MaterialStateProperty.all(
            Colors.transparent), // Avoid default highlight
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: appTextStyle(
          isDarkMode: isDarkMode,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive
              ? isDarkMode
                  ? AppConstants.textLight
                  : AppConstants.primaryColor
              : isDarkMode
                  ? AppConstants.greyColor
                  : AppConstants.greyColor,
        ),
      ),
    );
  }

  // Builds the Phone Input Row using country_code_picker
  Widget _buildPhoneInput(ThemeData theme, bool isDarkMode) {
    final backgroundColor = isDarkMode ? AppConstants.dark : AppConstants.light;
    final pickerDialogBgColor =
        isDarkMode ? AppConstants.dark : AppConstants.light;
    final pickerTextColor =
        isDarkMode ? AppConstants.textLight : AppConstants.textDark;
    ;

    return Row(
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          textStyle: appTextStyle(isDarkMode: isDarkMode), // Selected code text
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
            controller: _phoneController.value,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: appTextStyle(isDarkMode: isDarkMode),
            validator: Validators.phoneValidator, // Use your validator
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
    );
  }

  // Builds the Email Input Field
  Widget _buildEmailInput(ThemeData theme, bool isDarkMode) {
    return TextFormField(
      controller: _emailController.value,
      keyboardType: TextInputType.emailAddress,
      style: appTextStyle(isDarkMode: isDarkMode),
      validator: Validators.emailValidator, // Use your validator
      decoration: appInputDecoration(
        theme: theme,
        isDarkMode: isDarkMode,
        hintText: 'you@example.com',
        prefixIcon: Icons.alternate_email, // Standard email icon
      ),
      // Optional: Provide semantic label for accessibility
      // semanticsLabel: "Email address input field",
    );
  }
}