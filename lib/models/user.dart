class User {
  final String dni;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime lastLoginAt;

  User({
    required this.dni,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.lastLoginAt,
  });

  String get fullName => '$firstName $lastName';
  String get initials =>
      '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'
          .toUpperCase();

  // Create a copy of this user with potentially new values
  User copyWith({
    String? dni,
    String? email,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return User(
      dni: dni ?? this.dni,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  // Convert user to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': dni,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
    };
  }

  // Create user from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      dni: (json['dni'] ?? '').toString(),
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      lastLoginAt: DateTime.parse(
        json['lastLoginAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
