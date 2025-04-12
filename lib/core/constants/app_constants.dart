import 'dart:ui';

import 'package:adwise/core/constants/global.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

abstract class AppConstants {
  Global global = Global();

  // Colors
  static final Color primaryColor = Color.fromRGBO(24, 32, 102, 1);
  static final Color accentColor = Color.fromRGBO(50, 66, 186, 1);

  static final Color darkOpaque = Colors.black.withOpacity(0.1);
  static final Color lightOpaque = Colors.white.withOpacity(0.1); 
  static final Color greyOpaque = Colors.grey.withOpacity(0.1);


  static final Color dark = Color(0xFF212121);
  static final Color light = Colors.white;

  static final Color textDark = Color(0xFF212121);
  static final Color textLight = Colors.white;

  static final Color chatBackground = Color(0xFFECE5DD);
  static final String fontFamily = 'SFPro';
  static final String backgroundImagePath = 'assets/images/background1.png';

  static final String darkBackgroundImage = 'assets/images/background2.png';
  static final String lightBackgroundImage = 'assets/images/background1.png';
  static final String logo = 'assets/images/logo-Transparent.png';



  static final String care_image = 'assets/images/care_image.png';
  static final String introduction_animation =
      'assets/images/introduction_animation.png';
  static final String introduction_image =
      'assets/images/introduction_image.png';
  static final String mood_dairy_image = 'assets/images/mood_dairy_image.png';
  static final String relax_image = 'assets/images/relax_image.png';
  static final String welcome = 'assets/images/welcome.png';
  static final String loginBackgroundImagePath = "assets/images/login_dark.png";

  // Text
  static final String appName = "Adwise";
  static final String welcomeMessage = "Welcome to Adwise";
  static final String loginHeading = "Welcome to Adwise";
  static final String loginSubHeading =
      "Enter your email and password to continue";

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

  static final String userLoginURL =
      "https://adwise-service.onrender.com/auth/verify_otp";
  static final String userRegistrationURL =
      "https://adwise-service.onrender.com/auth/register";
  static final String webSocketURL =
      "ws://websocket-server-7y5w.onrender.com/ws?token=";
  static final String requestOTPURL =
      "https://adwise-service.onrender.com/auth/request_otp";
  static final String appID = Global().getAppID();

  static final Map<String, String> requestHeader = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'sec-fetch-dest': '',
    'mode': 'no-cors',
    'x-render-origin-server': 'Render',
    'Server': 'render',
    'Access-Control-Allow-Credentials': 'false',
    'AppID': appID,
  };

  static final grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

  static final MaterialColor primaryMaterialColor = MaterialColor(
    0xFF182066, // base color
    <int, Color>{
      50: Color(0xFFE5E6F0),
      100: Color(0xFFBEC1DB),
      200: Color(0xFF9499C3),
      300: Color(0xFF6A71AB),
      400: Color(0xFF4A5399),
      500: Color(0xFF182066), // base
      600: Color(0xFF161D5E),
      700: Color(0xFF131952),
      800: Color(0xFF101546),
      900: Color(0xFF0A0E30),
    },
  );

  static final Color blackColor = Color(0xFF16161E);
  static final Color blackColor80 = Color(0xFF45454B);
  static final Color blackColor60 = Color(0xFF737378);
  static final Color blackColor40 = Color(0xFFA2A2A5);
  static final Color blackColor20 = Color(0xFFD0D0D2);
  static final Color blackColor10 = Color(0xFFE8E8E9);
  static final Color blackColor5 = Color(0xFFF3F3F4);

  static final Color whiteColor = Colors.white;
  static final Color whileColor80 = Color(0xFFCCCCCC);
  static final Color whileColor60 = Color(0xFF999999);
  static final Color whileColor40 = Color(0xFF666666);
  static final Color whileColor20 = Color(0xFF333333);
  static final Color whileColor10 = Color(0xFF191919);
  static final Color whileColor5 = Color(0xFF0D0D0D);

  static final Color greyColor = Color(0xFFB8B5C3);
  static final Color lightGreyColor = Color(0xFFF8F8F9);
  static final Color darkGreyColor = Color(0xFF1C1C25);
// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

  static final Color successColor = Color(0xFF2ED573);
  static final Color warningColor = Color(0xFFFFBE21);
  static final Color errorColor = Color(0xFFEA5B5B);

  static final double defaultPadding = 16.0;
  static final EdgeInsets defaultPaddingEdgeAll = EdgeInsets.all(
                                    defaultPadding * 0.5);
  static final double defaultBorderRadious = 12.0;
  static final Duration defaultDuration = Duration(milliseconds: 300);

}

//Template Default Values

// Just for demo
const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";

// End For demo

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);

const pasNotMatchErrorText = "passwords do not match";
