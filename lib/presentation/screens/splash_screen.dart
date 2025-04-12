import 'package:adwise/core/constants/app_constants.dart';
// import 'package:adwise/presentation/screens/auth/login_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemUiOverlayStyle
import 'dart:async';

import 'loginScreen.dart';

// import 'package:flutter_svg/flutter_svg.dart'; // Use if your logo is SVG
// import 'home_screen.dart'; // Replace with your actual home screen import
// import 'login_screen.dart'; // Replace with your actual login screen import
// import 'auth_service.dart'; // Replace with your actual auth service import

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin { // Needed for AnimationController
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  static const int _splashDurationSeconds = 3; // Min display time

  @override
  void initState() {
    super.initState();

    // --- Animation Setup ---
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // Duration of fade-in
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut, // Smooth fade curve
    );

    _animationController.forward(); // Start the animation

    // --- Navigation Logic ---
    _initializeAppAndNavigate();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose controller to free resources
    super.dispose();
  }

  Future<void> _initializeAppAndNavigate() async {
    // Record the start time
    final startTime = DateTime.now();

    // --- Simulate App Initialization ---
    // Perform essential async tasks here *before* navigating.
    // Examples:
    // 1. Check authentication status
    // 2. Load user preferences or essential config
    // 3. Initialize services (database, notifications)

    // Example: Replace with your actual auth check
    // final bool isLoggedIn = await AuthService().isAuthenticated();
    await Future.delayed(const Duration(milliseconds: 1500)); // Simulate work
    const bool isLoggedIn = false; // Placeholder

    // --- Calculate remaining time ---
    final endTime = DateTime.now();
    final initDuration = endTime.difference(startTime);
    final remainingTime =
        Duration(seconds: _splashDurationSeconds) - initDuration;

    // Ensure splash screen is shown for the minimum duration
    if (remainingTime.isNegative == false) { // Check if .isNegative needed
         await Future.delayed(remainingTime);
    }


    // --- Navigate ---
    // Use pushReplacement to prevent users from navigating back to the splash screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => isLoggedIn
              ? const PlaceholderScreen(title: "Home Screen") // Keep placeholder or replace with HomeScreen() later
              // vvv MODIFY THIS LINE vvv
              : const LoginScreen(), // Replace placeholder with your LoginScreen
              // ^^^ MODIFY THIS LINE ^^^
        ),
      );
    }



    // if (mounted) { // Check if the widget is still in the tree
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => isLoggedIn
    //           ? const PlaceholderScreen(title: "Home Screen") // Replace with HomeScreen()
    //           : const PlaceholderScreen(title: "Login Screen"), // Replace with LoginScreen()
    //     ),
    //   );
    // }


  }

  @override
  Widget build(BuildContext context) {
    // Optional: Customize status bar style for the splash screen
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make status bar transparent
      statusBarIconBrightness: Brightness.dark, // Use dark icons (for light background)
    ));

    return Scaffold(
      // Use a theme color or define explicitly
      backgroundColor: const Color(0xFFF0F4F8), // Light blue-grey background
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- Logo ---
              // Option 1: PNG Logo (ensure it's in assets folder and pubspec.yaml)
              Image.asset(
                AppConstants.logo, // <<<--- CHANGE TO YOUR LOGO PATH
                height: 120.0, // Adjust size as needed
                errorBuilder: (context, error, stackTrace) =>
                 const Icon(Icons.error_outline, size: 80, color: Colors.redAccent), // Placeholder on error
              ),

              // Option 2: SVG Logo (Requires flutter_svg package)
              // SvgPicture.asset(
              //   'assets/logo/app_logo.svg', // <<<--- CHANGE TO YOUR LOGO PATH
              //    height: 120.0,
              // ),

              // Optional: Add a subtle loading indicator or app name/tagline below
              // const SizedBox(height: 24),
              // const CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              // ),
              // const SizedBox(height: 16),
              // Text(
              //   "Your Awesome App",
              //   style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black54),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


// --- Placeholder for next screens (Remove this in your actual app) ---
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(title),
         backgroundColor: const Color(0xFFF0F4F8), // Match splash background for transition
         elevation: 0, // No shadow for a cleaner look initially
         foregroundColor: Colors.black87,
      ),
      body: Center(
        child: Text('Welcome! This is the $title.'),
      ),
    );
  }
}