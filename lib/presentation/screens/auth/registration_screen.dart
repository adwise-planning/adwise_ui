import 'package:adwise/core/constants/app_styles.dart';
import 'package:adwise/core/services/auth_provider.dart';
import 'package:adwise/presentation/screens/auth/otp_screen.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String password;

  const RegistrationScreen({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

  class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedCountryCode = "+1"; // Default country code
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Only set initial values once here
    _selectedCountryCode = widget.countryCode;
    _phoneController.text = widget.phoneNumber;
    _emailController.text = widget.email;
    _passwordController.text = widget.password;  // Set initial password here
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

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
                    _buildTextField(_firstNameController, 'First Name', true),
                    _buildTextField(
                        _middleNameController, 'Middle Name', false),
                    _buildTextField(_lastNameController, 'Last Name', true),
                    _buildTextField(
                        _displayNameController, 'Display Name', false),
                    _buildEmailField(),
                    _buildPhoneField(),
                    _buildPasswordField(),
                    _buildConfirmPasswordField(),
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

  Widget _buildTextField(
      TextEditingController controller, String label, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: inputFieldDecoration(false), // Use the global decoration
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none, // Remove default border to use custom one
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          validator: isRequired
              ? (value) =>
                  value == null || value.isEmpty ? '$label is required' : null
              : null,
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: inputFieldDecoration(false),
        child: TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[a-zA-Z]{2,7})+$')
                .hasMatch(value)) {
              return 'Invalid email format';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Match other fields
      child: Container(
        width: double.infinity,
        decoration: inputFieldDecoration(false), // Global decoration
        padding: const EdgeInsets.symmetric(
            horizontal: 12.0, vertical: 0), // Consistent height
        child: Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountryCode,
                icon: const Icon(Icons.arrow_drop_down,
                    color: AppConstants.primaryColor),
                style: const TextStyle(fontSize: 16),
                items: AppConstants.countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['code'],
                    child: Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          country['flag']!,
                          width: 24,
                          height: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          country['code']!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCountryCode = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: _phoneController,
                autofillHints: const [AutofillHints.telephoneNumber],
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.grey),
                  errorStyle: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: inputFieldDecoration(false),
        child: TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword, // Only one obscureText property
          decoration: InputDecoration(
            labelText: 'Password',
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppConstants.primaryColor,
              ),
              onPressed: _togglePasswordVisibility, // Toggle visibility
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Widget _buildConfirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: inputFieldDecoration(false), // Using global decoration
        child: TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscurePassword, // Toggle visibility
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
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
            builder: (context) => OtpScreen(countryCode: widget.countryCode , phoneNumber: widget.phoneNumber),
          ),
        );
      }
    }
  }
}
