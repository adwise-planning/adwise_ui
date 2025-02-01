import 'dart:ui';

abstract class AppConstants {
  // Colors
  static const Color primaryColor = Color.fromRGBO(24, 32, 102, 1);
  static const Color accentColor = Color.fromRGBO(50, 66, 186, 1);
  static const Color chatBackground = Color(0xFFECE5DD);
  static const String fontFamily = 'Croogla';


  // Text
  static const String appName = "Adwise";
  static const String welcomeMessage = "Welcome to Adwise";

  static const List<Map<String, String>> countries = [
    {'name': 'United States', 'code': '+1', 'flag': 'US'},
    {'name': 'India', 'code': '+91', 'flag': 'IN'},
    {'name': 'United Kingdom', 'code': '+44', 'flag': 'GB'},
    {'name': 'Australia', 'code': '+61', 'flag': 'AU'},
    {'name': 'Germany', 'code': '+49', 'flag': 'DE'},
  ];


}