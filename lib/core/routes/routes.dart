import 'package:Adwise/presentation/screens/auth/login_screen.dart';
import 'package:Adwise/presentation/screens/auth/otp_screen.dart';
import 'package:Adwise/presentation/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OtpScreen(
        phoneNumber: state.extra as String,
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);