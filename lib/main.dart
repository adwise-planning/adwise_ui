import 'package:Adwise/core/constants/app_constants.dart';
import 'package:Adwise/core/services/logger_service.dart';
import 'package:Adwise/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';

// Entry point of the app
void main() {
  final logger = AppLogger();
  logger.info("App started successfully");
  // Run the app with the provider scope and the main app widget
  runApp(const ProviderScope(child: AdwiseApp()));
}

// Main app widget: MyApp. It is a stateless widget. It creates a MaterialApp with a title, theme, dark theme and router configuration.
class AdwiseApp extends StatelessWidget {
  const AdwiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: LoginScreen(), // Set the initial screen to LoginScreen
    );
  }
}