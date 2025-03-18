class UserSettings {
  // Private fields
  String _userId;
  bool _darkMode;
  String _language;
  String _theme; // New field: Theme preference (e.g., light, dark, system)
  bool _emailNotifications; // New field: Email notification preference
  bool _pushNotifications; // New field: Push notification preference
  bool _smsNotifications; // New field: SMS notification preference
  String _timezone; // New field: User's timezone
  bool _analyticsEnabled; // New field: Analytics tracking preference
  bool _locationTracking; // New field: Location tracking preference
  DateTime _settingsUpdatedAt; // New field: Timestamp when settings were last updated

  // Constructor
  UserSettings({
    required String userId,
    bool darkMode = false,
    String language = 'en',
    String theme = 'system',
    bool emailNotifications = true,
    bool pushNotifications = true,
    bool smsNotifications = false,
    String timezone = 'UTC',
    bool analyticsEnabled = false,
    bool locationTracking = false,
    required DateTime settingsUpdatedAt,
  })  : _userId = userId,
        _darkMode = darkMode,
        _language = language,
        _theme = theme,
        _emailNotifications = emailNotifications,
        _pushNotifications = pushNotifications,
        _smsNotifications = smsNotifications,
        _timezone = timezone,
        _analyticsEnabled = analyticsEnabled,
        _locationTracking = locationTracking,
        _settingsUpdatedAt = settingsUpdatedAt {
    // Validate fields during initialization
    _validateUserId(userId);
    _validateLanguage(language);
    _validateTheme(theme);
    _validateTimezone(timezone);
  }

  // Getters
  String get userId => _userId;
  bool get darkMode => _darkMode;
  String get language => _language;
  String get theme => _theme;
  bool get emailNotifications => _emailNotifications;
  bool get pushNotifications => _pushNotifications;
  bool get smsNotifications => _smsNotifications;
  String get timezone => _timezone;
  bool get analyticsEnabled => _analyticsEnabled;
  bool get locationTracking => _locationTracking;
  DateTime get settingsUpdatedAt => _settingsUpdatedAt;

  // Setters with validation
  set userId(String value) {
    _validateUserId(value);
    _userId = value;
  }

  set darkMode(bool value) {
    _darkMode = value;
  }

  set language(String value) {
    _validateLanguage(value);
    _language = value;
  }

  set theme(String value) {
    _validateTheme(value);
    _theme = value;
  }

  set emailNotifications(bool value) {
    _emailNotifications = value;
  }

  set pushNotifications(bool value) {
    _pushNotifications = value;
  }

  set smsNotifications(bool value) {
    _smsNotifications = value;
  }

  set timezone(String value) {
    _validateTimezone(value);
    _timezone = value;
  }

  set analyticsEnabled(bool value) {
    _analyticsEnabled = value;
  }

  set locationTracking(bool value) {
    _locationTracking = value;
  }

  set settingsUpdatedAt(DateTime value) {
    _settingsUpdatedAt = value;
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

  void _validateLanguage(String language) {
    if (language.isEmpty) {
      throw ArgumentError('Language cannot be empty.');
    }
    if (!['en', 'es', 'fr', 'de', 'zh'].contains(language.toLowerCase())) {
      throw ArgumentError('Unsupported language.');
    }
  }

  void _validateTheme(String theme) {
    if (theme.isEmpty) {
      throw ArgumentError('Theme cannot be empty.');
    }
    if (!['light', 'dark', 'system'].contains(theme.toLowerCase())) {
      throw ArgumentError('Invalid theme.');
    }
  }

  void _validateTimezone(String timezone) {
    if (timezone.isEmpty) {
      throw ArgumentError('Timezone cannot be empty.');
    }
    if (!RegExp(r'^[A-Za-z]+\/[A-Za-z_]+$').hasMatch(timezone)) {
      throw ArgumentError('Invalid timezone format.');
    }
  }

  // Method to update the settings' last updated timestamp
  void updateSettingsTimestamp() {
    _settingsUpdatedAt = DateTime.now();
  }

  @override
  String toString() => 'UserSettings(userId: $_userId, darkMode: $_darkMode, language: $_language, '
      'theme: $_theme, emailNotifications: $_emailNotifications, pushNotifications: $_pushNotifications, '
      'smsNotifications: $_smsNotifications, timezone: $_timezone, analyticsEnabled: $_analyticsEnabled, '
      'locationTracking: $_locationTracking, settingsUpdatedAt: $_settingsUpdatedAt)';
}