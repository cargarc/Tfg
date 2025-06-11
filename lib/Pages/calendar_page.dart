import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;

  // Mapa para almacenar eventos (fecha -> lista de eventos)
  final Map<DateTime, List<Event>> _events = {};

  // Lista de eventos seleccionados
  List<Event> _selectedEvents = [];

  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // Agregar algunos eventos de ejemplo
    _events[DateTime(2023, 1, 15)] = [
      Event(
        cod: '001',
        fechaIni: DateTime(2025, 6, 9),
        fechaFin: DateTime(2025, 6, 10),
        horaPrevistaIni: TimeOfDay(hour: 9, minute: 0),
        coste: 100.0,
        presupuestoInicial: 150.0,
        presupuestoFinal: 120.0,
        estado: 'Pendiente',
      ),
      Event(
        cod: '002',
        fechaIni: DateTime(2023, 1, 16),
        fechaFin: DateTime(2023, 1, 17),
        horaPrevistaIni: TimeOfDay(hour: 10, minute: 30),
        coste: 200.0,
        presupuestoInicial: 250.0,
        presupuestoFinal: 220.0,
        estado: 'Completado',
      ),
    ];
    setState(() {
      _selectedEvents = _events[_selectedDay!] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Acción al presionar el botón de notificaciones
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Acción al presionar el botón de configuración
            },
          ),
        ],
      ),
      body: Center(
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2050, 12, 31),
          calendarFormat: CalendarFormat.month,
          onDaySelected: (selectedDay, focusedDay) {
            // Acción al seleccionar un día
            print('Día seleccionado: $selectedDay');
          },
          eventLoader: (day) {
            return _events[day] ?? [];
          },
          onPageChanged: (focusedDay) {
            // Acción al cambiar de página
            _focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
