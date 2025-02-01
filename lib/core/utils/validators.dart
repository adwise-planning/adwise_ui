class Validators {
  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Phone required';
    if (!RegExp(r'^\+?[0-9]{10,}$').hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  // Email Validator
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password Validator
  static String? passwordValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Password is required'
        : (value.length < 6 ? 'Password must be at least 6 characters' : null);
  }
}
