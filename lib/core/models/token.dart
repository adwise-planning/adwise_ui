import 'dart:math';

class Token {
  // Private fields
  String _token;
  DateTime _expiry;
  String _userId;
  String _tokenType; // New field: Type of token (e.g., access, refresh)
  String _scope; // New field: Scope of the token (e.g., read, write)
  DateTime _createdAt; // New field: Timestamp when the token was created
  bool _isRevoked; // New field: Indicates if the token is revoked
  String _issuer; // New field: Issuer of the token
  String _audience; // New field: Intended audience for the token

  // Constructor
  Token({
    required String token,
    required DateTime expiry,
    required String userId,
    String tokenType = 'access',
    String scope = 'read',
    required DateTime createdAt,
    bool isRevoked = false,
    String issuer = 'my-app',
    String audience = 'my-app-client',
  })  : _token = token,
        _expiry = expiry,
        _userId = userId,
        _tokenType = tokenType,
        _scope = scope,
        _createdAt = createdAt,
        _isRevoked = isRevoked,
        _issuer = issuer,
        _audience = audience {
    // Validate fields during initialization
    _validateToken(token);
    _validateTokenType(tokenType);
    _validateScope(scope);
  }

  // Getters
  String get token => _token;
  DateTime get expiry => _expiry;
  String get userId => _userId;
  String get tokenType => _tokenType;
  String get scope => _scope;
  DateTime get createdAt => _createdAt;
  bool get isRevoked => _isRevoked;
  String get issuer => _issuer;
  String get audience => _audience;

  // Setters with validation
  set token(String value) {
    _validateToken(value);
    _token = value;
  }

  set expiry(DateTime value) {
    _expiry = value;
  }

  set userId(String value) {
    _validateUserId(value);
    _userId = value;
  }

  set tokenType(String value) {
    _validateTokenType(value);
    _tokenType = value;
  }

  set scope(String value) {
    _validateScope(value);
    _scope = value;
  }

  set isRevoked(bool value) {
    _isRevoked = value;
  }

  set issuer(String value) {
    _issuer = value;
  }

  set audience(String value) {
    _audience = value;
  }

  // Validation methods
  void _validateToken(String token) {
    if (token.isEmpty) {
      throw ArgumentError('Token cannot be empty.');
    }
    if (token.length < 64) {
      throw ArgumentError('Token must be at least 64 characters.');
    }
  }

  void _validateUserId(String userId) {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty.');
    }
    if (!RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(userId)) {
      throw ArgumentError('User ID must be alphanumeric.');
    }
  }

  void _validateTokenType(String tokenType) {
    if (tokenType.isEmpty) {
      throw ArgumentError('Token type cannot be empty.');
    }
    if (!['access', 'refresh'].contains(tokenType.toLowerCase())) {
      throw ArgumentError('Invalid token type.');
    }
  }

  void _validateScope(String scope) {
    if (scope.isEmpty) {
      throw ArgumentError('Scope cannot be empty.');
    }
    if (!['read', 'write', 'read_write'].contains(scope.toLowerCase())) {
      throw ArgumentError('Invalid scope.');
    }
  }

  // Method to check if the token is valid
  bool isValid() {
    return !_isRevoked && DateTime.now().isBefore(_expiry);
  }

  // Method to revoke the token
  void revoke() {
    _isRevoked = true;
  }

  // Method to generate a new token
  static String generateToken() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(64, (index) => chars[random.nextInt(chars.length)]).join();
  }

  @override
  String toString() => 'Token(userId: $_userId, token: $_token, expiry: $_expiry, '
      'tokenType: $_tokenType, scope: $_scope, createdAt: $_createdAt, '
      'isRevoked: $_isRevoked, issuer: $_issuer, audience: $_audience, valid: ${isValid()})';
}