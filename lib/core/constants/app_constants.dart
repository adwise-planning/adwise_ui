import 'dart:ui';

abstract class AppConstants {
  // Colors
  static const Color primaryColor = Color.fromRGBO(24, 32, 102, 1);
  static const Color accentColor = Color.fromRGBO(50, 66, 186, 1);
  static const Color chatBackground = Color(0xFFECE5DD);
  static const String fontFamily = 'SFPro';
  static const String backgroundImagePath = 'assets/images/background2.png';
  static const String logo = 'assets/images/logo-Transparent.png';

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

  static var primaryColorShade = Color.fromRGBO(24, 32, 102, 1);

  static const String testUser = "user1";
  static const String testUserToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InVzZXIxQGcuY29tIiwiZGV2aWNlX2lkIjoieDBfMksyMlBTIiwiZW1haWwiOiJ1c2VyMUBnLmNvbSIsImV4cCI6MTc0MTQ5MDM2MywiaWF0IjoxNzQxNDA1MzM2fQ.9i5cax6Jpr5l6Fyp8KmTrnY6_Xv60YNDUb9CZvcj7xA";

  static const String testUserR = "";
  static const String testUserRToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InVzZXIxQGcuY29tIiwiZGV2aWNlX2lkIjoieDBfMksyMlBTIiwiZW1haWwiOiJ1c2VyMUBnLmNvbSIsImV4cCI6MTc0MTQ5MDM2MywiaWF0IjoxNzQxNDA1MzM2fQ.9i5cax6Jpr5l6Fyp8KmTrnY6_Xv60YNDUb9CZvcj7xA";
}
