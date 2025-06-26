import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/employee.dart';
import 'package:flutter_application_2/models/event.dart';
import 'package:flutter_application_2/service/event-service.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final EventService _eventService = EventService();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  bool _isLoading = true;
  String _errorMessage = '';

  // Mapa para almacenar eventos (fecha -> lista de eventos)
  final Map<DateTime, List<Event>> _events = {};
  final employee = Employee();

  // Lista de eventos seleccionados
  List<Event> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    //try {

    final events =
        employee.categoria == 'gerente' || employee.categoria == 'organizacion'
            ? await _eventService.getEvents()
            : await _eventService.getEventsByEmployee(employee.dni ?? '');

    // Limpiar eventos anteriores
    _events.clear();

    // Organizar eventos por fecha
    for (final event in events) {
      final dateKey = DateTime(
        event.fechaIni.year,
        event.fechaIni.month,
        event.fechaIni.day,
      );

      if (_events[dateKey] == null) {
        _events[dateKey] = [];
      }
      _events[dateKey]!.add(event);
    }

    setState(() {
      _selectedEvents = _events[_selectedDay!] ?? [];
      _isLoading = false;
    });
    //} catch (e) {
    //  setState(() {
    //   _isLoading = false;
    // _errorMessage = 'Error al cargar eventos: ${e.toString()}';
    //});
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadEvents),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TableCalendar<Event>(
                      focusedDay: _focusedDay,
                      firstDay: DateTime.utc(2010, 1, 1),
                      lastDay: DateTime.utc(2050, 12, 31),
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        final day = DateTime(
                          selectedDay.year,
                          selectedDay.month,
                          selectedDay.day,
                        );
                        setState(() {
                          _selectedDay = day;
                          _focusedDay = focusedDay;
                          _selectedEvents = _events[day] ?? [];
                        });
                      },
                      eventLoader: (day) {
                        return _events[DateTime(
                              day.year,
                              day.month,
                              day.day,
                            )] ??
                            [];
                      },
                      onPageChanged: (focusedDay) {
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
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child:
                          _selectedEvents.isEmpty
                              ? const Center(
                                child: Text('No hay eventos para este día'),
                              )
                              : ListView.builder(
                                itemCount: _selectedEvents.length,
                                itemBuilder: (context, index) {
                                  final event = _selectedEvents[index];
                                  return _buildEventCard(event);
                                },
                              ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Evento ${event.cod}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(event.estado!).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    event.estado!.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(event.estado!),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            _buildDetailRow(
              Icons.calendar_today,
              '${_formatDate(event.fechaIni)} - ${_formatDate(event.fechaFin)}',
            ),
            _buildDetailRow(
              Icons.access_time,
              'Hora inicio: ${event.horaPrevistaIni.format(context)}',
            ),
            _buildDetailRow(
              Icons.attach_money,
              'Costo: \$${event.coste.toStringAsFixed(0)}',
            ),
            _buildDetailRow(
              Icons.account_balance_wallet,
              'Presupuesto: \$${event.presupuestoInicial.toStringAsFixed(0)} (inicial)',
            ),
            _buildDetailRow(
              Icons.account_balance_wallet,
              'Presupuesto: \$${event.presupuestoModificado.toStringAsFixed(0)} (modificado)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'validado':
        return Colors.green;
      case 'pendiente':
        return Colors.orange;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
