import 'dart:convert';

import 'package:flutter_application_2/models/event.dart';
import 'package:http/http.dart' as http;

class EventService {
  static const String _baseUrl = 'http://localhost:3000/api';

  Future<List<Event>> getEvents() async {
    String url = "$_baseUrl/events";
    print('Solicitando eventos a: $url');
    try {
      final response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final eventsData = data['data'] as List;
        print('Eventos recibidos: ${eventsData.length}');
        print('Datos del Evento: $eventsData');

        return eventsData
            .map((eventJson) => Event.fromJson(eventJson))
            .toList();
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        throw Exception('Error al cargar eventos: ${response.statusCode}');
      }
    } catch (e) {
      print('Excepción en getEvents: $e');
      throw Exception('Error de conexión: $e');
    }
  }
}
