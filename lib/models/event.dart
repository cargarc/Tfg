import 'package:flutter/material.dart';

class Event {
  final String cod;
  final DateTime fechaIni;
  final DateTime fechaFin;
  final TimeOfDay horaPrevistaIni;
  final double coste;
  final double presupuestoInicial;
  final double presupuestoFinal;
  final String estado;

  Event({
    required this.cod,
    required this.fechaIni,
    required this.fechaFin,
    required this.horaPrevistaIni,
    required this.coste,
    required this.presupuestoInicial,
    required this.presupuestoFinal,
    required this.estado,
  });

  Event copyWith({
    String? cod,
    DateTime? fechaIni,
    DateTime? fechaFin,
    HourFormat? horaPrevistaIni,
    double? coste,
    double? presupuestoInicial,
    double? presupuestoFinal,
    String? estado,
  }) {
    return Event(
      cod: cod ?? this.cod,
      fechaIni: fechaIni ?? this.fechaIni,
      fechaFin: fechaFin ?? this.fechaFin,
      horaPrevistaIni: this.horaPrevistaIni,
      coste: coste ?? this.coste,
      presupuestoInicial: presupuestoInicial ?? this.presupuestoInicial,
      presupuestoFinal: presupuestoFinal ?? this.presupuestoFinal,
      estado: estado ?? this.estado,
    );
  }

  // Convert event to JSON
  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'fechaIni': fechaIni.toIso8601String(),
      'fechaFin': fechaFin.toIso8601String(),
      'horaPrevistaIni': '${horaPrevistaIni.hour}:${horaPrevistaIni.minute}',
      'coste': coste,
      'presupuestoInicial': presupuestoInicial,
      'presupuestoFinal': presupuestoFinal,
      'estado': estado,
    };
  }
}
