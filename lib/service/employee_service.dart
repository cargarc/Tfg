import 'dart:convert';

import 'package:flutter_application_2/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static const String _baseUrl = 'http://localhost:3000/api';

  Future<Employee> getEmployeeById(String dni) async {
    final response = await http
        .post(
          Uri.parse('$_baseUrl/employee/data/$dni'),
          headers: {'Content-Type': 'application/json'},
        )
        .timeout(const Duration(seconds: 10));

    print('Respuesta recibida. Código: ${response}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('Datos del empleado: $data');

      return Employee(
        dni: data['dni'],
        nombre: data['nombre'],
        apellidos: data['apellidos'],
        numSS: data['numSS'],
        categoria: data['categoria'],
        email: data['email'],
      );
    } else {
      print('Error al obtener el empleado: ${response.statusCode}');
      throw Exception('Error al obtener el empleado: ${response.body}');
    }
  }
}
