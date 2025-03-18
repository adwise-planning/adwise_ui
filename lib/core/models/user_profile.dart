class UserProfile {
  // Private fields
  String _userId;
  String _avatarUrl;
  String _bio;
  String _website;
  String _socialMediaLinks;
  DateTime _profileCreatedAt;
  DateTime _profileUpdatedAt;
  String _jobTitle; // New field: Job title of the user
  String _company; // New field: Company the user works for
  String _location; // New field: User's location
  String _pronouns; // New field: User's pronouns
  List<String> _interests; // New field: List of user's interests

  // Constructor
  UserProfile({
    required String userId,
    required String avatarUrl,
    required String bio,
    String website = '',
    String socialMediaLinks = '',
    required DateTime profileCreatedAt,
    required DateTime profileUpdatedAt,
    String jobTitle = '',
    String company = '',
    String location = '',
    String pronouns = '',
    List<String> interests = const [],
  })  : _userId = userId,
        _avatarUrl = avatarUrl,
        _bio = bio,
        _website = website,
        _socialMediaLinks = socialMediaLinks,
        _profileCreatedAt = profileCreatedAt,
        _profileUpdatedAt = profileUpdatedAt,
        _jobTitle = jobTitle,
        _company = company,
        _location = location,
        _pronouns = pronouns,
        _interests = interests {
    // Validate fields during initialization
    _validateUserId(userId);
    _validateAvatarUrl(avatarUrl);
    _validateBio(bio);
    _validateWebsite(website);
  }

  // Getters
  String get userId => _userId;
  String get avatarUrl => _avatarUrl;
  String get bio => _bio;
  String get website => _website;
  String get socialMediaLinks => _socialMediaLinks;
  DateTime get profileCreatedAt => _profileCreatedAt;
  DateTime get profileUpdatedAt => _profileUpdatedAt;
  String get jobTitle => _jobTitle;
  String get company => _company;
  String get location => _location;
  String get pronouns => _pronouns;
  List<String> get interests => _interests;

  // Setters with validation
  set userId(String value) {
    _validateUserId(value);
    _userId = value;
  }

  set avatarUrl(String value) {
    _validateAvatarUrl(value);
    _avatarUrl = value;
  }

  set bio(String value) {
    _validateBio(value);
    _bio = value;
  }

  set website(String value) {
    _validateWebsite(value);
    _website = value;
  }

  set socialMediaLinks(String value) {
    _socialMediaLinks = value;
  }

  set jobTitle(String value) {
    _jobTitle = value;
  }

  set company(String value) {
    _company = value;
  }

  set location(String value) {
    _location = value;
  }

  set pronouns(String value) {
    _pronouns = value;
  }

  set interests(List<String> value) {
    _interests = value;
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

  void _validateAvatarUrl(String avatarUrl) {
    if (avatarUrl.isEmpty) {
      throw ArgumentError('Avatar URL cannot be empty.');
    }
    if (!Uri.tryParse(avatarUrl)!.hasAbsolutePath ?? true) {
      throw ArgumentError('Invalid avatar URL.');
    }
  }

  void _validateBio(String bio) {
    if (bio.isEmpty) {
      throw ArgumentError('Bio cannot be empty.');
    }
    if (bio.length > 500) {
      throw ArgumentError('Bio cannot exceed 500 characters.');
    }
  }

  void _validateWebsite(String website) {
    if (website.isNotEmpty && !Uri.tryParse(website)!.hasAbsolutePath ?? true) {
      throw ArgumentError('Invalid website URL.');
    }
  }

  // Method to update the profile's last updated timestamp
  void updateProfileTimestamp() {
    _profileUpdatedAt = DateTime.now();
  }

  // Method to add an interest
  void addInterest(String interest) {
    if (!_interests.contains(interest)) {
      _interests.add(interest);
    }
  }

  // Method to remove an interest
  void removeInterest(String interest) {
    _interests.remove(interest);
  }

  @override
  String toString() => 'UserProfile(userId: $_userId, avatarUrl: $_avatarUrl, bio: $_bio, '
      'website: $_website, socialMediaLinks: $_socialMediaLinks, profileCreatedAt: $_profileCreatedAt, '
      'profileUpdatedAt: $_profileUpdatedAt, jobTitle: $_jobTitle, company: $_company, '
      'location: $_location, pronouns: $_pronouns, interests: $_interests)';
}