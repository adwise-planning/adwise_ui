import 'package:Adwise/core/constants/app_constants.dart';
import 'package:Adwise/core/routes/routes.dart';
import 'package:Adwise/core/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';

void main() {
  final logger = AppLogger();
  logger.info("App started successfully");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
    );
  }
}