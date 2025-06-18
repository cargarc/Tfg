import 'package:flutter/widgets.dart';

class Calendar extends StatefulWidget {
  final DateTime fechaIni;
  final DateTime fechaFin;
  final String horaPrevistaIni;
  //final CalendarFormat CalendarFormat;

  Calendar({
    Key? key,
    required this.fechaIni,
    required this.fechaFin,
    required this.horaPrevistaIni,
    // required this.CalendarFormat,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
