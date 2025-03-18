import 'dart:ui';

import 'package:adwise/core/constants/global.dart';

abstract class AppConstants {
  Global global = Global();

  // Colors
  static const Color primaryColor = Color.fromRGBO(24, 32, 102, 1);
  static const Color accentColor = Color.fromRGBO(50, 66, 186, 1);
  static final Color chatBackground = Color(0xFFECE5DD);
  static final String fontFamily = 'SFPro';
  static final String backgroundImagePath = 'assets/images/background4.png';
  static final String logo = 'assets/images/logo-Transparent.png';

  // Text
  static final String appName = "Adwise";
  static final String welcomeMessage = "Welcome to Adwise";

  static final List<Map<String, String>> countries = [
    {'name': 'United States', 'code': '+1', 'flag': 'US'},
    {'name': 'India', 'code': '+91', 'flag': 'IN'},
    {'name': 'United Kingdom', 'code': '+44', 'flag': 'GB'},
    {'name': 'Australia', 'code': '+61', 'flag': 'AU'},
    {'name': 'Germany', 'code': '+49', 'flag': 'DE'},
  ];

  static final primaryColorShade = Color.fromRGBO(24, 32, 102, 1);

  static final String testUser = "user1";
  static final String testUserToken = "";

  static final String testUserR = "";
  static final String testUserRToken = "";

  // static final String userLoginURL = "https://websocket-server-7y5w.onrender.com/login";
  // static final String userRegistrationURL = "https://websocket-server-7y5w.onrender.com/register";
  // static final String webSocketURL = "ws://websocket-server-7y5w.onrender.com/ws?token=";
  // static final String requestOTPURL = "https://websocket-server-7y5w.onrender.com/login" ;

  static final String userLoginURL = "https://adwise-service.onrender.com/auth/verify_otp";
  static final String userRegistrationURL = "https://adwise-service.onrender.com/auth/register";
  static final String webSocketURL = "ws://websocket-server-7y5w.onrender.com/ws?token=";
  static final String requestOTPURL = "https://adwise-service.onrender.com/auth/request_otp" ;
  static final String appID = Global().getAppID();
  
  static final Map<String,String> requestHeader = {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'sec-fetch-dest': '',
          'mode': 'no-cors',
          'x-render-origin-server': 'Render',
          'Server': 'render',
          'Access-Control-Allow-Credentials': 'false',
          'AppID': appID,
        };
}