import 'package:Adwise/core/services/logger_service.dart';
import 'package:Adwise/presentation/screens/home/service_selection_screen.dart';
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
  final String? uuid;
  final String? userId;
  final String? phone;

  AuthState(
      {this.status = AuthStateStatus.initial,
      this.error,
      this.authToken,
      this.uuid,
      this.userId,
      this.phone});

  AuthState copyWith(
      {AuthStateStatus? status,
      String? error,
      String? authToken,
      String? userId,
      String? uuid,
      String? phone}) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      authToken: authToken ?? this.authToken,
      userId: userId ?? this.userId,
      uuid: uuid ?? this.uuid,
      phone: phone ?? this.phone,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());
  final logger = AppLogger();

  BuildContext? _context;
  void setContext(BuildContext context) {
    _context = context;
  }

  //  Send OTP to the provided phone number
  Future<void> sendOTP(String phone) async {
    state = state.copyWith(status: AuthStateStatus.loading, phone: phone);
    try {
      // state = state.copyWith(status: AuthStateStatus.success);
      final response = await http.post(
        Uri.parse('https://adwise-service.onrender.com/api/login'),
        headers: {
          'Content-Type': 'application/json',
          //'Access-Control-Allow-Origin': '*',
          'sec-fetch-dest': '',
          'mode': 'no-cors',
          'x-render-origin-server' : 'Render',
          'Server': 'cloudflare',
          'Access-Control-Allow-Credentials': 'false',
        },
        body: jsonEncode({"country_code":"001", "phone_number":phone, "password":"pass", "is_email_login":false}),
      );
      // slogger.info('response: $response.statusCode');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        state = state.copyWith(
          status: AuthStateStatus.success,
          authToken: data['token'],
          uuid: data['uuid'],
          phone: phone,
        );
        print("Login successful for uuid: ${data['uuid']}, Token: ${data['token']}");
        print("Login2 successful for uuid: ${state.uuid}, Token: ${state.authToken}");
      } else {
        logger.warn("Error getting OTP for phone number: $phone");
        // throw Exception('Failed to send OTP');
      }

      // Always success
      state = state.copyWith(status: AuthStateStatus.success, phone: phone);
      if (_context != null && _context!.mounted) {
          _context!.go('/otp', extra: phone);
      }
    } catch (e) {
      logger.error("Error logging in phone number: $phone", e);
      state =
          state.copyWith(status: AuthStateStatus.error, error: e.toString(), phone: phone);
    }
  }

  // Verify the OTP entered by the user
  Future<void> verifyOTP(BuildContext context, String otp) async {
    state = state.copyWith(status: AuthStateStatus.loading);
    try {
      // TO DO: Integrate with backend
      await Future.delayed(const Duration(seconds: 2)); // Mock delay
      state = state.copyWith(status: AuthStateStatus.success);
      print(state);
      print(context);
      print(context.mounted);
      if (context.mounted) {
        Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceSelectionScreen(
                                    authToken: state.authToken  ?? 'Unknown Token',
                                    userId: state.uuid  ?? 'Unknown UUID',
                                  ),
                                ),
                              );

        // print("Navigating to service selection");
        // context.go('/service_selection');
      }
    } catch (e) {
      state =
          state.copyWith(status: AuthStateStatus.error, error: e.toString());
    }
  }

  // Login with email
  Future<void> loginWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStateStatus.loading);

    final credentials = {
      'username': email.trim(),
      'email': email.trim(),
      'password': password,
    };

      // final deviceData = {
      //   'device_id': deviceInfo['device_id'],
      //   'name': deviceInfo['name'],
      //   'type': deviceInfo['type'],
      //   'manufacturer': deviceInfo['manufacturer'],
      //   'model': deviceInfo['model'],
      //   'serial_number': deviceInfo['serial_number'],
      //   'imei': deviceInfo['imei'],
      //   'firmware': deviceInfo['firmware'],
      //   'hardware_version': deviceInfo['hardware_version'],
      //   'software_version': deviceInfo['software_version'],
      //   'operating_system': deviceInfo['operating_system'],
      //   'processor': deviceInfo['processor'],
      //   'memory': deviceInfo['memory'],
      //   'storage_capacity': deviceInfo['storage_capacity'],
      //   'battery_level': deviceInfo['battery_level'],
      //   'ip_address': deviceInfo['ip_address'],
      //   'mac_address': deviceInfo['mac_address'],
      //   'connectivity_type': deviceInfo['connectivity_type']
      // };

    final body = {
      'credentials': credentials,
      'device': {"device_id": "x0_2K22PS", "name": "samsung x1"}
    };

    logger.info("Status Code: ${body}");

    try {
      final response = await http.post(
        Uri.parse('https://websocket-server-7y5w.onrender.com/login'),
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'false',
          //'Access-Control-Allow-Origin': 'http://localhost:59054',
          'sec-fetch-dest': '',
          'mode': 'no-cors'
        },
        body: jsonEncode(body),
      );

      logger.info("Status Code: ${response.statusCode}");
      logger.info("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final authToken = responseBody['access_token'];
        print('authToken: '+ authToken);
        final userId =
            responseBody['user_id']; // Adjust based on actual API response

        state = state.copyWith(
          status: AuthStateStatus.success,
          authToken: authToken,
          userId: userId,
        );

        if (_context != null && _context!.mounted) {
          _context!.go('/service_selection');
        }
      } else {
        logger.warn("Invalid email or password");
        state = state.copyWith(
          status: AuthStateStatus.error,
          error: 'Invalid email or password',
        );
      }
    } catch (e) {
      logger.error("Error logging in with email: $email", e);
      state = state.copyWith(
        status: AuthStateStatus.error,
        error: 'Failed to connect to the server',
      );
    }
    
    // simulation without backend integration
    // try {
    //   // TO DO: Integrate with backend

    //   // Simulate email login API call
    //   await Future.delayed(const Duration(seconds: 2));
    //   state = state.copyWith(status: AuthStateStatus.success);
    //   if (_context != null && _context!.mounted) {
    //     _context!.go('/service_selection');
    //   }
    // } catch (e) {
    //   logger.error("Error logging in email: $email", e);
    //   state = state.copyWith(
    //       status: AuthStateStatus.error, error: 'Failed to login with email');
    // }
  }

  // Clear errors before retrying
  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
