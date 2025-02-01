import 'package:Adwise/core/constants/app_constants.dart';
import 'package:Adwise/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LoginScreen(), // We'll create this next
    );
  }
}