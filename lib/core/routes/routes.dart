import 'package:Adwise/core/services/auth_provider.dart';
import 'package:Adwise/presentation/screens/auth/login_screen.dart';
import 'package:Adwise/presentation/screens/auth/otp_screen.dart';
import 'package:Adwise/presentation/screens/chat/chat_screen.dart';
import 'package:Adwise/presentation/screens/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    
    GoRoute(
      path: '/chat/:chatId',
      builder: (context, state) => Consumer(
        builder: (context, ref, child) {
          return ChatScreen(
            chatId: state.pathParameters['chatId']!,
            recipientName: state.extra as String,
            authToken: ref.read(authProvider).authToken ?? '',
          );
        },
      ),
    ),

  ],
);