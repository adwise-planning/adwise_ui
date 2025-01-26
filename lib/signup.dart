// ignore_for_file: camel_case_types, avoid_print

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
//import 'package:telephony/telephony.dart';

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
  final TextEditingController _passwordController = TextEditingController(); // Password controller

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
          : (value.length < 6 ? 'Password must be at least 6 characters' : null);
    });
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final battery = Battery();
    final networkInfo = NetworkInfo();
    // final connectivity = Connectivity();
    final packageInfo = await PackageInfo.fromPlatform();

    String deviceId = "Unknown";
    String name = "Unknown";
    String manufacturer = "Unknown";
    String model = "Unknown";
    String osVersion = "Unknown";
    String serialNumber = "Unknown";
    String hardwareVersion = "Unknown";
    String processor = "Unknown";
    int memory = 0;
    int storageCapacity = 0;
    String ip = "Unknown";
    String macAddress = "Unknown";
    String connectivityType = "Unknown";
    int batteryLevel = 0;

    print(Platform);

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      name = androidInfo.device;
      manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
      osVersion = "Android ${androidInfo.version.release}";
      serialNumber = androidInfo.serialNumber;
      hardwareVersion = androidInfo.hardware;
      memory = androidInfo.systemFeatures.length; // Example for memory
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "Unknown";
      name = iosInfo.name;
      manufacturer = "Apple";
      model = iosInfo.utsname.machine;
      osVersion = iosInfo.systemVersion;
      serialNumber = "N/A"; // Serial numbers are restricted on iOS
      hardwareVersion = iosInfo.systemName;
    }

    // Battery Info
    batteryLevel = await battery.batteryLevel;

    // Network Info
    ip = await networkInfo.getWifiIP() ?? "Unknown";
    macAddress = await networkInfo.getWifiBSSID() ?? "Unknown";

    return {
      'device_id': deviceId,
      'name': name,
      'type': Platform.operatingSystem,
      'manufacturer': manufacturer,
      'model': model,
      'serial_number': serialNumber,
      'imei': Platform.isAndroid ? (await deviceInfo.androidInfo).id : "N/A",
      'firmware': osVersion,
      'hardware_version': hardwareVersion,
      'software_version': packageInfo.version,
      'operating_system': osVersion,
      'processor': processor,
      'memory': memory,
      'storage_capacity': storageCapacity,
      'battery_level': batteryLevel,
      'ip_address': ip,
      'mac_address': macAddress,
      'connectivity_type': connectivityType,
      'status': "Active",
      'last_seen': DateTime.now().toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
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
        final deviceInfo = await _getDeviceInfo();
        
        final url = Uri.parse('https://your-backend.com/api/signup'); // Replace with your API endpoint
        
        final body = {
          'first_name': _firstNameController.text.trim(),
          'last_name': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(), // Include password here
          'dob': _dobController.text.trim(),
          'country': _selectedCountry,
          'zipcode': _zipcodeController.text.trim(),
          'phone': '$_selectedCountryCode${_phoneNumberController.text.trim()}',
          'device_id': deviceInfo['device_id'],
          'name': deviceInfo['name'],
          'type': deviceInfo['type'],
          'manufacturer': deviceInfo['manufacturer'],
          'model': deviceInfo['model'],
          'serial_number': deviceInfo['serial_number'],
          'imei': deviceInfo['imei'],
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
          'connectivity_type': deviceInfo['connectivity_type'],
        };
        
        print(body);
        
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Welcome to Adwise!')),
          );
          Navigator.pop(context); // Navigate to login or another screen
        } else {
          final responseData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message'] ?? 'Signup failed'),
            ),
          );
        }
      } catch (e) {
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
                const SizedBox(height: 24, width:100),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, // Text color
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
