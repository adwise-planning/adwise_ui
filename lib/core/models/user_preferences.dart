class UserPreferences {
  // Private fields
  String _userId;
  bool _receiveNotifications;
  bool _locationTracking;
  bool _analyticsConsent; // New field: Consent for analytics tracking
  bool _marketingConsent; // New field: Consent for marketing communications
  bool _showOnlineStatus; // New field: Preference to show online status
  bool _allowFriendRequests; // New field: Preference to allow friend requests
  String _privacyLevel; // New field: Privacy level (e.g., public, friends-only, private)
  DateTime _preferencesUpdatedAt; // New field: Timestamp when preferences were last updated

  // Constructor
  UserPreferences({
    required String userId,
    bool receiveNotifications = true,
    bool locationTracking = false,
    bool analyticsConsent = false,
    bool marketingConsent = false,
    bool showOnlineStatus = true,
    bool allowFriendRequests = true,
    String privacyLevel = 'friends-only',
    required DateTime preferencesUpdatedAt,
  })  : _userId = userId,
        _receiveNotifications = receiveNotifications,
        _locationTracking = locationTracking,
        _analyticsConsent = analyticsConsent,
        _marketingConsent = marketingConsent,
        _showOnlineStatus = showOnlineStatus,
        _allowFriendRequests = allowFriendRequests,
        _privacyLevel = privacyLevel,
        _preferencesUpdatedAt = preferencesUpdatedAt {
    // Validate fields during initialization
    _validateUserId(userId);
    _validatePrivacyLevel(privacyLevel);
  }

  // Getters
  String get userId => _userId;
  bool get receiveNotifications => _receiveNotifications;
  bool get locationTracking => _locationTracking;
  bool get analyticsConsent => _analyticsConsent;
  bool get marketingConsent => _marketingConsent;
  bool get showOnlineStatus => _showOnlineStatus;
  bool get allowFriendRequests => _allowFriendRequests;
  String get privacyLevel => _privacyLevel;
  DateTime get preferencesUpdatedAt => _preferencesUpdatedAt;

  // Setters with validation
  set userId(String value) {
    _validateUserId(value);
    _userId = value;
  }

  set receiveNotifications(bool value) {
    _receiveNotifications = value;
  }

  set locationTracking(bool value) {
    _locationTracking = value;
  }

  set analyticsConsent(bool value) {
    _analyticsConsent = value;
  }

  set marketingConsent(bool value) {
    _marketingConsent = value;
  }

  set showOnlineStatus(bool value) {
    _showOnlineStatus = value;
  }

  set allowFriendRequests(bool value) {
    _allowFriendRequests = value;
  }

  set privacyLevel(String value) {
    _validatePrivacyLevel(value);
    _privacyLevel = value;
  }

  set preferencesUpdatedAt(DateTime value) {
    _preferencesUpdatedAt = value;
  }

  // Validation methods
  void _validateUserId(String userId) {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty.');
    }
    if (!RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(userId)) {
      throw ArgumentError('User ID must be alphanumeric.');
    }
  }

  void _validatePrivacyLevel(String privacyLevel) {
    if (privacyLevel.isEmpty) {
      throw ArgumentError('Privacy level cannot be empty.');
    }
    if (!['public', 'friends-only', 'private'].contains(privacyLevel.toLowerCase())) {
      throw ArgumentError('Invalid privacy level.');
    }
  }

  // Method to update the preferences' last updated timestamp
  void updatePreferencesTimestamp() {
    _preferencesUpdatedAt = DateTime.now();
  }

  @override
  String toString() => 'UserPreferences(userId: $_userId, receiveNotifications: $_receiveNotifications, '
      'locationTracking: $_locationTracking, analyticsConsent: $_analyticsConsent, '
      'marketingConsent: $_marketingConsent, showOnlineStatus: $_showOnlineStatus, '
      'allowFriendRequests: $_allowFriendRequests, privacyLevel: $_privacyLevel, '
      'preferencesUpdatedAt: $_preferencesUpdatedAt)';
}