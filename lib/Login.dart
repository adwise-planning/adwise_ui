import 'package:flutter/material.dart';
import 'package:adwise/chatscreen.dart'; // Import the chatscreen_web.dart

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

  void validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    setState(() {
      _emailError = value.isEmpty
          ? 'Email is required'
          : (!emailRegex.hasMatch(value) ? 'Enter a valid email address' : null);
    });
  }

  void validatePassword(String value) {
    setState(() {
      _passwordError = value.isEmpty
          ? 'Password is required'
          : (value.length < 6 ? 'Password must be at least 6 characters' : null);
    });
  }

  void _handleLogin() {
    validateEmail(_emailController.text);
    validatePassword(_passwordController.text);

    if (_emailError == null && _passwordError == null) {
      // Navigate to ChatScreenWeb on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            username: _emailController.text, // Pass username from email
            status: 'Online',               // Set status dynamically
            authToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiSEIiLCJleHAiOjE3Mzc0ODU0NjV9.KDxKTNbgee2Wxk8ASnrWm1-8LINVhgVO79jt-UmWG6I', // Replace with real token
          ),
        ),
      );
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
              maxWidth: 400, // Same width constraint as the signup form
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
                    ),
                    obscureText: true,
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
                            const SnackBar(content: Text('Forgot Password clicked')), // Replace with navigation
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
