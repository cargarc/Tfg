import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/check_hours.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Acción al presionar el botón de notificaciones
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Acción al presionar el botón de configuración
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menú'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Calendario'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Horas trabajadas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Checkhours()),
                );
              },
            ),
            ListTile(
              title: Text('Almacen'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Personal'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Tareas'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Gestión Eventos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Mensajes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenido a la página de inicio'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Checkhours()),
                );
              },
              child: Text('Ver horas trabajadas'),
            ),
          ],
        ),
      ),
    );
  }
}
