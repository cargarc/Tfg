import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_2/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';
  static const String _baseUrl = 'http://localhost:3000/api';
  Future<AuthResult> login(String email, String password) async {
    print('Intentando conectar a: $_baseUrl/auth/login');
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/auth/login'),
            body: jsonEncode({'email': email, 'contraseña': password}),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10)); // Timeout opcional

      print('Respuesta recibida. Código: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Respuesta del servidor: $data');
        final user = User.fromJson(data['user']);
        await _saveUser(user);
        await saveCurrentUser(user);
        // await _saveToken(data['token']);
        return AuthResult(success: true, user: user, message: 'Login exitoso');
      } else {
        print('Error del servidor: ${response.statusCode}');
        throw Exception('Error en login: ${response.body}');
      }
    } on SocketException catch (e) {
      print('Error de conexión: $e');
      throw Exception('No se pudo conectar al servidor');
    } on TimeoutException catch (e) {
      print('Tiempo de espera agotado: $e');
      throw Exception('El servidor no respondió a tiempo');
    } catch (e) {
      print('Error inesperado: $e');
      throw Exception('Error desconocidooooo');
    }
  }

  // Guardar usuario actual
  Future<void> saveCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
  }

  // Obtener usuario actual
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_currentUserKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _getUsers();

    // Check if user already exists
    final index = users.indexWhere((u) => u.dni == user.dni);

    if (index >= 0) {
      users[index] = user;
    } else {
      users.add(user);
    }

    await prefs.setStringList(
      _usersKey,
      users.map((u) => jsonEncode(u.toJson())).toList(),
    );
  }

  Future<List<User>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_usersKey) ?? [];

    return usersJson
        .map((userJson) => User.fromJson(jsonDecode(userJson)))
        .toList();
  }
}

class AuthResult {
  final bool success;
  final String message;
  final User? user;

  AuthResult({required this.success, required this.message, this.user});
}
