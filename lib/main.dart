import 'package:adwise/core/constants/app_constants.dart';
import 'package:adwise/core/constants/global.dart';
import 'package:adwise/core/constants/global_background.dart';
import 'package:adwise/core/services/logger_service.dart';
import 'package:adwise/presentation/introduction_animation/introduction_animation_screen.dart';
import 'package:adwise/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';

// Entry point of the app
void main() {
  final logger = AppLogger();
  final global = Global();
  global.init();
  String appUqniqueID = global.getAppID();
  logger.info("App (appID: $appUqniqueID) started successfully");
  // Run the app with the provider scope and the main app widget
  runApp(ProviderScope(child: AdwiseApp(appUqniqueID)));
}

// Main app widget: MyApp. It is a stateless widget. It creates a MaterialApp with a title, theme, dark theme and router configuration.
class AdwiseApp extends StatelessWidget {
  const AdwiseApp(String appUqniqueID, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      //home: LoginScreen(), // Set the initial screen to LoginScreen
        home: IntroductionAnimationScreen(),
      // builder: (context, child) {
      //   return GlobalBackgroundWidget(child: child ?? const SizedBox()); // Wrap the app content with the background widget
      // },

      builder: (context, child) {
        return GlobalBackgroundWidget(
          backgroundImagePath: AppConstants.backgroundImagePath, // Ensure path is passed here
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}