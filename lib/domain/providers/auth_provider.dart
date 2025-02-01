import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStateStatus { initial, loading, success, error }

class AuthState {
  final AuthStateStatus status;
  final String? error;

  AuthState({this.status = AuthStateStatus.initial, this.error});

  AuthState copyWith({AuthStateStatus? status, String? error}) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<void> sendOTP(String phone) async {
    state = state.copyWith(status: AuthStateStatus.loading);
    try {
      // TODO: Integrate with backend
      // Simulate phone OTP API call
     await Future.delayed(const Duration(seconds: 2)); // Mock delay
      state = state.copyWith(status: AuthStateStatus.success);
    } catch (e) {
      state =
          state.copyWith(status: AuthStateStatus.error, error: e.toString());
    }
  }

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
