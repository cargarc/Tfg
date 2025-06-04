class User {
  final String dni;
  final String email;
  final double contadorHoras;
  final String estado;
  final double salario;

  User({
    required this.dni,
    required this.email,
    required this.contadorHoras,
    required this.estado,
    required this.salario,
  });

  // Create a copy of this user with potentially new values
  User copyWith({
    String? dni,
    String? email,
    String? estado,
    double? contadorHoras,
    double? salario,
  }) {
    return User(
      dni: dni ?? this.dni,
      email: email ?? this.email,
      contadorHoras: contadorHoras ?? 0.0,
      estado: estado ?? '',
      salario: salario ?? 0.0,
    );
  }

  // Convert user to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': dni,
      'email': email,
      'contadorHoras': contadorHoras,
      'estado': estado,
      'salario': salario,
    };
  }

  // Create user from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      dni: (json['dni'] ?? '').toString(),
      email: json['email'] ?? '',
      contadorHoras: (json['contadorHoras'] ?? 0.0).toDouble(),
      estado: json['estado'] ?? '',
      salario: (json['salario'] ?? 0.0).toDouble(),
    );
  }
}
