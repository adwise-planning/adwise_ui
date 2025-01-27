import 'dart:convert';
import 'package:adwise/deviceinfo.dart';
import 'package:flutter/material.dart';
import 'package:adwise/chatscreen.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _rememberMe = false;
  bool _isPasswordVisible = false; // To track password visibility

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

  void validatePassword(String value) {
    setState(() {
      _passwordError = value.isEmpty
          ? 'Password is required'
          : (value.length < 6
              ? 'Password must be at least 6 characters'
              : null);
    });
  }

  void _handleLogin() async {
    validateEmail(_emailController.text);
    validatePassword(_passwordController.text);

    if (_emailError == null && _passwordError == null) {
      final deviceInfo = await DeviceInfo().getDeviceInfo();

      final credentials = {
        'username': _emailController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
      };

      final deviceData = {
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
        'connectivity_type': deviceInfo['connectivity_type']
      };

      final body = {'credentials': credentials, 'device': deviceData};
      print("Request Body: $body");

      final response = await http.post(
        Uri.parse('https://websocket-server-7y5w.onrender.com/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );

      // Print response details
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("Response Headers: ${response.headers}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final authToken = responseBody['access_token'];
        print("Returned Token: $authToken");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              username: _emailController.text,
              status: 'Online',
              authToken: authToken,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                    onChanged: validatePassword,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Forgot Password clicked'),
                            ),
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
