import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/check_hours.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Contador')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Numero de clicks'), Text('contador')],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _crearBotones(),
    );
  }

  void _botonSuma() {
    setState(() => contador++);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Checkhours()),
    );
  }

  void _botonCero() {}

  void _botonMenos() {}

  _crearBotones() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Icon(Icons.exposure_zero),
            onPressed: () => _botonCero(),
          ),
          Expanded(child: SizedBox()),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () => _botonMenos(),
          ),
          SizedBox(width: 5),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _botonSuma(),
          ),
        ],
      ),
    );
  }
}
