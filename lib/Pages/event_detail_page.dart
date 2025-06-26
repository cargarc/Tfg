import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/request_event.dart';

class EventDetailPage extends StatefulWidget {
  final RequestEvent? requestEvent;
  const EventDetailPage({super.key, this.requestEvent});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.requestEvent?.cod ?? 'Detalles del Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Codigo: ${widget.requestEvent?.cod ?? 'No disponible'}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Descripción Material: ${widget.requestEvent?.descripcionMaterial ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Descripción Personal: ${widget.requestEvent?.descripcionPersonal ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fecha de Inicio: ${widget.requestEvent?.fechaIni ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fecha de Fin: ${widget.requestEvent?.fechaFin ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Duración: ${widget.requestEvent?.duracion ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Dirección: ${widget.requestEvent?.direccion ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Aforo: ${widget.requestEvent?.aforo ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Metros cuadrados: ${widget.requestEvent?.m2 ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Estado: ${widget.requestEvent?.estado ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Presupuesto: ${widget.requestEvent?.presupuesto ?? 'No disponible'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Material: ')),
                  Expanded(child: Text('Personal:  ')),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
