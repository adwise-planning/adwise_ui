class User {
  // Private fields
  String? _id;
  String? _first_name;
  String? _middle_name;
  String? _last_name;
  String? _display_name;
  String? _email;
  DateTime? _createdAt;
  DateTime? _updatedAt;
  String _role;
  bool _isActive;
  String? _phoneCountryCode;
  String? _phoneNumber;
  String? _address;
  String? _country;

  // Constructor
  User({
    String? id,
    String? first_name,
    String? last_name,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? middle_name,
    String? display_name,
    String role = 'user',
    bool isActive = true,
    String? phoneCountryCode,
    String? phoneNumber,
    String? address,
    String? country,
  })  : _id = id,
        _first_name = first_name,
        _middle_name = middle_name,
        _last_name = last_name,
        _display_name = display_name,
        _email = email,
        _createdAt = createdAt ?? DateTime.now(),
        _updatedAt = updatedAt ?? DateTime.now(),
        _role = role,
        _isActive = isActive,
        _phoneCountryCode = phoneCountryCode,
        _phoneNumber = phoneNumber,
        _address = address,
        _country = country {
  }

  // Getters
  String? get id => _id!;
  String? get first_name => _first_name!;
  String? get middle_name => _middle_name!;
  String? get last_name => _last_name!;
  String? get display_name => _display_name!;
  String? get email => _email!;
  DateTime? get createdAt => _createdAt!;
  DateTime? get updatedAt => _updatedAt!;
  String get role => _role!;
  bool get isActive => _isActive!;
  String? get phoneCountryCode => _phoneCountryCode!;
  String? get phoneNumber => _phoneNumber!;
  String? get address => _address!;
  String? get country => _country!;

  // Setters with validation
  set id(String? value) {
    _id = value;
  }

  set first_name(String? value) {
    _validateName(value, 'First name');
    _first_name = value;
  }

  set middle_name(String? value) {
    _middle_name = value;
  }

  set last_name(String? value) {
    _validateName(value, 'Last name');
    _last_name = value;
  }

  set display_name(String? value) {
    _display_name = value;
  }

  set email(String? value) {
    _validateEmail(value);
    _email = value;
  }

  set role(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Role cannot be empty.');
    }
    _role = value;
  }

  set isActive(bool value) {
    _isActive = value;
  }

  set phoneCountryCode(String? value) {
    _validateCountryCode(value);
    _phoneCountryCode = value;
  }

  set phoneNumber(String? value) {
    _validatePhoneNumber(value);
    _phoneNumber = value;
  }

  set address(String? value) {
    _address = value;
  }

  set country(String? value) {
    _country = value;
  }

  void _validateName(String? name, String fieldName) {
    if (name!.isEmpty) {
      throw ArgumentError('$fieldName cannot be empty.');
    }
    if (name.length > 50) {
      throw ArgumentError('$fieldName cannot exceed 50 characters.');
    }
  }

  void _validateEmail(String? email) {
    if (email!.isEmpty) {
      throw ArgumentError('Email cannot be empty.');
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      throw ArgumentError('Invalid email format.');
    }
  }

  void _validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber!.isNotEmpty &&
        !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(phoneNumber)) {
      throw ArgumentError('Invalid phone number format.');
    }
  }

  void _validateCountryCode(String? countryCode) {
    if (countryCode!.isNotEmpty &&
        !RegExp(r'^\+[0-9]{1,4}$').hasMatch(countryCode)) {
      throw ArgumentError('Invalid country code format.');
    }
  }

  // Method to update the user's last updated timestamp
  void updateTimestamp() {
    _updatedAt = DateTime.now();
  }

  @override
  String toString() =>
      'User(id: $_id, first_name: $_first_name, middle_name: $_middle_name, '
      'last_name: $_last_name, display_name: $_display_name, email: $_email, createdAt: $_createdAt, '
      'updatedAt: $_updatedAt, role: $_role, isActive: $_isActive, phoneCountryCode: $_phoneCountryCode, '
      'phoneNumber: $_phoneNumber, address: $_address, country: $_country)';
}
