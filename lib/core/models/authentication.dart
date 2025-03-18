import 'dart:math';
import 'user.dart';

class Authentication extends User {
  // Private fields
  String? _passwordHash;
  bool _isAuthenticated;
  bool _isEmailLogin;
  DateTime? _lastLogin;
  int _failedLoginAttempts;
  bool _isLocked;
  String _twoFactorAuthMethod;
  DateTime? _passwordLastChanged;
  String _sessionToken; // New field: Session token for the user
  DateTime _sessionExpiry; // New field: Expiry time of the session token
  List<String> _recentPasswords; // New field: List of recently used passwords (for password history)
  bool _isPasswordExpired; // New field: Indicates if the password is expired

  // Constructor
  Authentication({
    String? id,
    String? first_name,
    String? last_name,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? passwordHash,
    bool isAuthenticated = false,
    bool isEmailLogin = false,
    DateTime? lastLogin,
    int failedLoginAttempts = 0,
    bool isLocked = false,
    String twoFactorAuthMethod = 'none',
    DateTime? passwordLastChanged,
    String sessionToken = '',
    DateTime? sessionExpiry,
    List<String> recentPasswords = const [],
    bool isPasswordExpired = false,
  })  : _passwordHash = passwordHash,
        _isEmailLogin = isEmailLogin,
        _isAuthenticated = isAuthenticated,
        _lastLogin = lastLogin,
        _failedLoginAttempts = failedLoginAttempts,
        _isLocked = isLocked,
        _twoFactorAuthMethod = twoFactorAuthMethod,
        _passwordLastChanged = passwordLastChanged,
        _sessionToken = sessionToken,
        _sessionExpiry = sessionExpiry ?? DateTime.now(),
        _recentPasswords = recentPasswords,
        _isPasswordExpired = isPasswordExpired,
        super(
          id: id,
          first_name: first_name,
          last_name: last_name,
          email: email,
          createdAt: createdAt,
          updatedAt: updatedAt,
        ) {
  }

  // Getters
  String? get passwordHash => _passwordHash;
  bool get isAuthenticated => _isAuthenticated;
  DateTime get lastLogin => _lastLogin!;
  int get failedLoginAttempts => _failedLoginAttempts;
  bool get isLocked => _isLocked;
  bool get isEmailLogin => _isEmailLogin;
  String get twoFactorAuthMethod => _twoFactorAuthMethod;
  DateTime get passwordLastChanged => _passwordLastChanged!;
  String get sessionToken => _sessionToken;
  DateTime get sessionExpiry => _sessionExpiry;
  List<String> get recentPasswords => _recentPasswords;
  bool get isPasswordExpired => _isPasswordExpired;

  // Setters with validation
  set passwordHash(String? value) {
    _validatePasswordHash(value);
    _passwordHash = value;
    _passwordLastChanged = DateTime.now();
    _recentPasswords.add(value!); // Add the new password to the history
  }

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
  }

  set isEmailLogin(bool value) {
    _isEmailLogin = value;
  }

  set lastLogin(DateTime value) {
    _lastLogin = value;
  }

  set failedLoginAttempts(int value) {
    _failedLoginAttempts = value;
    if (_failedLoginAttempts >= 5) {
      _isLocked = true;
    }
  }

  set isLocked(bool value) {
    _isLocked = value;
  }

  set twoFactorAuthMethod(String value) {
    _validateTwoFactorAuthMethod(value);
    _twoFactorAuthMethod = value;
  }

  set sessionToken(String value) {
    _sessionToken = value;
  }

  set sessionExpiry(DateTime value) {
    _sessionExpiry = value;
  }

  set isPasswordExpired(bool value) {
    _isPasswordExpired = value;
  }

  // Validation methods
  void _validatePasswordHash(String? passwordHash) {
    if (passwordHash!.isEmpty) {
      throw ArgumentError('Password hash cannot be empty.');
    }
    if (passwordHash.length < 64) {
      throw ArgumentError('Password hash must be at least 64 characters.');
    }
  }

  void _validateTwoFactorAuthMethod(String method) {
    if (!['none', 'sms', 'email', 'authenticator']
        .contains(method.toLowerCase())) {
      throw ArgumentError('Invalid two-factor authentication method.');
    }
  }

  // Method to authenticate the user
  void authenticate(String password) {
    if (_isLocked) {
      throw Exception('Account is locked. Please reset your password.');
    }
    if (_passwordHash == password) {
      _isAuthenticated = true;
      _failedLoginAttempts = 0;
      _lastLogin = DateTime.now();
    } else {
      _failedLoginAttempts++;
      if (_failedLoginAttempts >= 5) {
        _isLocked = true;
      }
      throw Exception('Invalid password.');
    }
  }

  // Method to reset the password
  void resetPassword(String newPasswordHash) {
    if (_recentPasswords.contains(newPasswordHash)) {
      throw Exception('Password cannot be reused.');
    }
    _passwordHash = newPasswordHash;
    _passwordLastChanged = DateTime.now();
    _isLocked = false;
    _isPasswordExpired = false;
    _recentPasswords.add(newPasswordHash);
  }

  // Method to check if the session is valid
  bool isSessionValid() {
    return DateTime.now().isBefore(_sessionExpiry);
  }

  // Method to generate a new session token
  void generateSessionToken() {
    _sessionToken = _generateRandomToken();
    _sessionExpiry =
        DateTime.now().add(Duration(hours: 1)); // Token expires in 1 hour
  }

  // Helper method to generate a random token
  String _generateRandomToken() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(64, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  @override
  String toString() =>
      'Authentication(${super.toString()}, isAuthenticated: $_isAuthenticated, '
      'lastLogin: $_lastLogin, failedLoginAttempts: $_failedLoginAttempts, isLocked: $_isLocked, '
      'twoFactorAuthMethod: $_twoFactorAuthMethod, passwordLastChanged: $_passwordLastChanged, '
      'sessionToken: $_sessionToken, sessionExpiry: $_sessionExpiry, isPasswordExpired: $_isPasswordExpired)';
}
