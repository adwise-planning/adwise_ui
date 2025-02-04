import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


enum AuthStateStatus { initial, loading, success, error }

class AuthState {

  final AuthStateStatus status;
  final String? error;
  final String? authToken;

  AuthState({this.status = AuthStateStatus.initial, this.error, this.authToken});

  AuthState copyWith({AuthStateStatus? status, String? error,  String? authToken}) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      authToken: authToken ?? this.authToken,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  BuildContext? _context;
  void setContext(BuildContext context) {
    _context = context;
  }

  //  Send OTP to the provided phone number
  Future<void> sendOTP(String phone) async {
    state = state.copyWith(status: AuthStateStatus.loading);
    try {
      // state = state.copyWith(status: AuthStateStatus.success);

      final response = await http.post(
        Uri.parse('https://websocket-server-7y5w.onrender.com/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        state = state.copyWith(
          status: AuthStateStatus.success,
          authToken: data['token'],
        );
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      state =
          state.copyWith(status: AuthStateStatus.error, error: e.toString());
    }
  }

  // Verify the OTP entered by the user
  Future<void> verifyOTP(String otp) async {
    state = state.copyWith(status: AuthStateStatus.loading);
    try {
      // TODO: Integrate with backend
      await Future.delayed(const Duration(seconds: 2)); // Mock delay
      state = state.copyWith(status: AuthStateStatus.success);
      if (_context != null && _context!.mounted) {
        _context!.go('/home');
      }
    } catch (e) {
      state =
          state.copyWith(status: AuthStateStatus.error, error: e.toString());
    }
  }

  // Login with email
  Future<void> loginWithEmail(String email) async {
    state = state.copyWith(status: AuthStateStatus.loading);
    try {
      // TODO: Integrate with backend
      // Simulate email login API call
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(status: AuthStateStatus.success);
    } catch (e) {
      state = state.copyWith(
          status: AuthStateStatus.error, error: 'Failed to login with email');
    }
  }

  // Clear errors before retrying
  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
