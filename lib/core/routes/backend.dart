



import 'dart:convert';
import 'package:adwise/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class BackendRequest {
  // Define a base URL for your backend API (if needed)
  BackendRequest();


// data: keys => email, phoneNumber, countryCode
Future<Map<String, dynamic>> requestOTP(Map<String, String>? header, Map<String, dynamic> data) async {
    try {
      header ??= AppConstants.requestHeader;
      // header['Authorization'] = "<token value>";
      final response = await http.post(
        Uri.parse(AppConstants.requestOTPURL),
        headers: header,
        body: jsonEncode(data),
      );

      // Status Code 200: Success, 400: Invalid Request, 422: Mal-formed Request, 429: Too Many Requests, 500: Internal Server Error 
      // "detail": {"error_code": "user_not_found","message": "User not registered"}

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse and return the response as a Map
        return jsonDecode(response.body);
      } else {
        return jsonDecode( "{'status': ${response.statusCode}, 'body': ${response.body}}");
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



Future<Map<String, dynamic>> postRequest(String url, Map<String, String>? header, Map<String, dynamic> data) async {
    try {
      header ??= AppConstants.requestHeader;
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(data),
      );

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse and return the response as a Map
        return jsonDecode(response.body);
      } else {
        return jsonDecode( "{'status': ${response.statusCode}, 'body': ${response.body}}");
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  // GET Request function
  Future<Map<String, dynamic>> getRequest(String url, Map<String, String>? header, String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$url/$endpoint'));
      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse and return the response as a Map
        return jsonDecode(response.body);
      } else {
        return jsonDecode( "{'status': ${response.statusCode}, 'body': ${response.body}}");
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}
