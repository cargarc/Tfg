import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/calendar_page.dart';
import 'package:flutter_application_2/Pages/check_hours.dart';
import 'package:flutter_application_2/Pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      //home: LoginPage(),
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/calendario': (context) => CalendarPage(),
        '/horas': (context) => Checkhours(),
        '/almacen': (context) => Center(child: Text('Almacén')),
        '/personal': (context) => Center(child: Text('Personal')),
        '/tareas': (context) => Center(child: Text('Tareas')),
        '/eventos': (context) => Center(child: Text('Gestión Eventos')),
        '/mensajes': (context) => Center(child: Text('Mensajes')),
        // Aquí puedes agregar más rutas si es necesario
      },
    );
  }
}
