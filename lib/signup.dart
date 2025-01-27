// ignore_for_file: camel_case_types, avoid_print

import 'dart:convert'; // For JSON encoding/decoding
import 'package:adwise/Home.dart';
import 'package:adwise/deviceinfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(); // Password controller

  String _selectedCountryCode = '+1'; // Default country code
  String _selectedCountry = 'United States'; // Default country
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _dobError;
  String? _zipcodeError;
  String? _phoneError;
  String? _passwordError; // Password error

  final List<String> _countries = [
    'United States',
    'India',
    'United Kingdom',
    'Australia',
    'Japan'
  ];

  final List<String> _countryCodes = ['+1', '+91', '+44', '+61', '+81'];

  void validateFirstName(String value) {
    setState(() {
      _firstNameError = value.isEmpty ? 'First name is required' : null;
    });
  }

  void validateLastName(String value) {
    setState(() {
      _lastNameError = value.isEmpty ? 'Last name is required' : null;
    });
  }

  void validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    setState(() {
      _emailError = value.isEmpty
          ? 'Email is required'
          : (!emailRegex.hasMatch(value)
              ? 'Enter a valid email address'
              : null);
    });
  }

  void validateDOB(String value) {
    setState(() {
      _dobError = value.isEmpty ? 'Date of birth is required' : null;
    });
  }

  void validateZipcode(String value) {
    setState(() {
      _zipcodeError = value.isEmpty ? 'Zipcode is required' : null;
    });
  }

  void validatePhoneNumber(String value) {
    setState(() {
      _phoneError = value.isEmpty
          ? 'Phone number is required'
          : (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)
              ? 'Phone number must be 10 digits'
              : null);
    });
  }

  void validatePassword(String value) {
    setState(() {
      _passwordError = value.isEmpty
          ? 'Password is required'
          : (value.length < 6
              ? 'Password must be at least 6 characters'
              : null);
    });
  }

  Future<void> _handleSignUp() async {
    validateFirstName(_firstNameController.text);
    validateLastName(_lastNameController.text);
    validateEmail(_emailController.text);
    validateDOB(_dobController.text);
    validateZipcode(_zipcodeController.text);
    validatePhoneNumber(_phoneNumberController.text);
    validatePassword(_passwordController.text); // Validate password

    if (_firstNameError == null &&
        _lastNameError == null &&
        _emailError == null &&
        _dobError == null &&
        _zipcodeError == null &&
        _phoneError == null &&
        _passwordError == null) {
      try {
        final deviceInfo = await DeviceInfo().getDeviceInfo();

        final url = Uri.parse(
            'https://websocket-server-7y5w.onrender.com/register'); // Replace with your API endpoint

        final user_data = {
          'username': _emailController.text.trim(),
          'password': _passwordController.text.trim(), // Include password here
          'first_name': _firstNameController.text.trim(),
          'last_name': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
          'address_line_1': '123 Main St',
          'address_line_2': 'Apt 101',
          'city': 'New York',
          'state': 'NY',
          'date_of_birth': _dobController.text.trim(),
          'country': _selectedCountry,
          'zip_code': _zipcodeController.text.trim(),
          'phone_country_code': _selectedCountryCode,
          'phone_number': '$_selectedCountryCode${_phoneNumberController.text.trim()}'
        };


        final device_data = {
          'device_id': deviceInfo['device_id'],
          'name': deviceInfo['name'],
          'type': deviceInfo['type'],
          'manufacturer': deviceInfo['manufacturer'],
          'model': deviceInfo['model'],
          'serial_number': deviceInfo['serial_number'],
          'imei': deviceInfo['imei'], // To be added to database and backend
          'firmware': deviceInfo['firmware'],
          'hardware_version': deviceInfo['hardware_version'],
          'software_version': deviceInfo['software_version'],
          'operating_system': deviceInfo['operating_system'],
          'processor': deviceInfo['processor'],
          'memory': deviceInfo['memory'],
          'storage_capacity': deviceInfo['storage_capacity'],
          'battery_level': deviceInfo['battery_level'],
          'ip_address': deviceInfo['ip_address'],
          'mac_address': deviceInfo['mac_address'],
          'connectivity_type': deviceInfo[
              'connectivity_type'] // To be added to database and backend
        };

        final body = {'user': user_data, 'device': device_data};

        print("Request Body: $body");

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );

        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Welcome to Adwise!')),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );

          // Navigator.pushReplacementNamed(context, '/home'); // Navigate to home page
        } else {
          final responseData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  responseData['message'] ?? 'Signup failed, Contact support'),
            ),
          );
        }
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth > 600 ? 400 : screenWidth * 0.9,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    errorText: _firstNameError,
                  ),
                  onChanged: validateFirstName,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    errorText: _lastNameError,
                  ),
                  onChanged: validateLastName,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _emailError,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: validateEmail,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController, // Password field
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _passwordError,
                  ),
                  onChanged: validatePassword,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    suffixIcon: const Icon(Icons.calendar_today),
                    errorText: _dobError,
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      _dobController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                      validateDOB(_dobController.text);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  items: _countries.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value!;
                      _selectedCountryCode =
                          _countryCodes[_countries.indexOf(value)];
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _zipcodeController,
                  decoration: InputDecoration(
                    labelText: 'Zipcode',
                    errorText: _zipcodeError,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: validateZipcode,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _selectedCountryCode,
                        items: _countryCodes.map((code) {
                          return DropdownMenuItem(
                            value: code,
                            child: Text(code),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountryCode = value!;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Country Code'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          errorText: _phoneError,
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: validatePhoneNumber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24, width: 100),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent, // Text color
                  ),
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
