class Device {
  // Private fields
  String _deviceId;
  String _deviceType;
  String _os;
  String _osVersion;
  String _manufacturer;
  String _model;
  DateTime _lastAccessed;
  String _ipAddress;
  bool _isTrusted;
  String _networkType; // New field: Type of network (e.g., WiFi, Cellular)
  String _macAddress; // New field: MAC address of the device
  String _browserInfo; // New field: Browser information (if applicable)
  bool _isEncrypted; // New field: Indicates if the device storage is encrypted
  String _securityPatchLevel; // New field: Security patch level of the OS

  // Constructor
  Device({
    required String deviceId,
    required String deviceType,
    required String os,
    required DateTime lastAccessed,
    String osVersion = '',
    String manufacturer = '',
    String model = '',
    String ipAddress = '',
    bool isTrusted = false,
    String networkType = 'WiFi',
    String macAddress = '',
    String browserInfo = '',
    bool isEncrypted = false,
    String securityPatchLevel = '',
  })  : _deviceId = deviceId,
        _deviceType = deviceType,
        _os = os,
        _osVersion = osVersion,
        _manufacturer = manufacturer,
        _model = model,
        _lastAccessed = lastAccessed,
        _ipAddress = ipAddress,
        _isTrusted = isTrusted,
        _networkType = networkType,
        _macAddress = macAddress,
        _browserInfo = browserInfo,
        _isEncrypted = isEncrypted,
        _securityPatchLevel = securityPatchLevel {
    // Validate fields during initialization
    _validateDeviceId(deviceId);
    _validateDeviceType(deviceType);
    _validateOS(os);
    _validateIPAddress(ipAddress);
    _validateMACAddress(macAddress);
  }

  // Getters
  String get deviceId => _deviceId;
  String get deviceType => _deviceType;
  String get os => _os;
  String get osVersion => _osVersion;
  String get manufacturer => _manufacturer;
  String get model => _model;
  DateTime get lastAccessed => _lastAccessed;
  String get ipAddress => _ipAddress;
  bool get isTrusted => _isTrusted;
  String get networkType => _networkType;
  String get macAddress => _macAddress;
  String get browserInfo => _browserInfo;
  bool get isEncrypted => _isEncrypted;
  String get securityPatchLevel => _securityPatchLevel;

  // Setters with validation
  set deviceId(String value) {
    _validateDeviceId(value);
    _deviceId = value;
  }

  set deviceType(String value) {
    _validateDeviceType(value);
    _deviceType = value;
  }

  set os(String value) {
    _validateOS(value);
    _os = value;
  }

  set osVersion(String value) {
    _osVersion = value;
  }

  set manufacturer(String value) {
    _manufacturer = value;
  }

  set model(String value) {
    _model = value;
  }

  set lastAccessed(DateTime value) {
    _lastAccessed = value;
  }

  set ipAddress(String value) {
    _validateIPAddress(value);
    _ipAddress = value;
  }

  set isTrusted(bool value) {
    _isTrusted = value;
  }

  set networkType(String value) {
    _networkType = value;
  }

  set macAddress(String value) {
    _validateMACAddress(value);
    _macAddress = value;
  }

  set browserInfo(String value) {
    _browserInfo = value;
  }

  set isEncrypted(bool value) {
    _isEncrypted = value;
  }

  set securityPatchLevel(String value) {
    _securityPatchLevel = value;
  }

  // Validation methods
  void _validateDeviceId(String deviceId) {
    if (deviceId.isEmpty) {
      throw ArgumentError('Device ID cannot be empty.');
    }
    if (!RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(deviceId)) {
      throw ArgumentError('Device ID must be alphanumeric.');
    }
  }

  void _validateDeviceType(String deviceType) {
    if (deviceType.isEmpty) {
      throw ArgumentError('Device type cannot be empty.');
    }
    if (!['mobile', 'desktop', 'tablet', 'other'].contains(deviceType.toLowerCase())) {
      throw ArgumentError('Invalid device type.');
    }
  }

  void _validateOS(String os) {
    if (os.isEmpty) {
      throw ArgumentError('OS cannot be empty.');
    }
    if (!['windows', 'macos', 'linux', 'android', 'ios'].contains(os.toLowerCase())) {
      throw ArgumentError('Unsupported OS.');
    }
  }

  void _validateIPAddress(String ipAddress) {
    if (ipAddress.isNotEmpty && !RegExp(r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$').hasMatch(ipAddress)) {
      throw ArgumentError('Invalid IP address.');
    }
  }

  void _validateMACAddress(String macAddress) {
    if (macAddress.isNotEmpty && !RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$').hasMatch(macAddress)) {
      throw ArgumentError('Invalid MAC address.');
    }
  }

  // Method to update the last accessed timestamp
  void updateLastAccessed() {
    _lastAccessed = DateTime.now();
  }

  @override
  String toString() => 'Device(deviceId: $_deviceId, deviceType: $_deviceType, os: $_os, osVersion: $_osVersion, '
      'manufacturer: $_manufacturer, model: $_model, lastAccessed: $_lastAccessed, ipAddress: $_ipAddress, '
      'isTrusted: $_isTrusted, networkType: $_networkType, macAddress: $_macAddress, browserInfo: $_browserInfo, '
      'isEncrypted: $_isEncrypted, securityPatchLevel: $_securityPatchLevel)';
}