class Employee {
  final String dni;
  final String nombre;
  final String apellidos;
  final String numSS;
  final String categoria;
  final String email;

  Employee({
    required this.dni,
    required this.nombre,
    required this.apellidos,
    required this.numSS,
    required this.categoria,
    required this.email,
  });

  Employee copyWith({
    String? dni,
    String? nombre,
    String? apellidos,
    String? numSS,
    String? categoria,
    String? email,
  }) {
    return Employee(
      dni: dni ?? this.dni,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      numSS: numSS ?? this.numSS,
      categoria: categoria ?? this.categoria,
      email: email ?? this.email,
    );
  }

  //COnvertir empleado a JSON
  Map<String, dynamic> toJson() {
    return {
      'dni': dni,
      'nombre': nombre,
      'apellidos': apellidos,
      'numSS': numSS,
      'categoria': categoria,
      'email': email,
    };
  }
}
