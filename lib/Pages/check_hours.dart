import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Checkhours extends StatelessWidget {
  Checkhours({Key? key}) : super(key: key);

  final dataMap = <String, double>{"Horas trabajadas": 5};

  final colorList = <Color>[Colors.greenAccent];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chesck Hours")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: const Color.fromARGB(
            255,
            40,
            40,
            40,
          )!.withOpacity(0.15),
          colorList: colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          totalValue: 20,
        ),
      ),
    );
  }
}
