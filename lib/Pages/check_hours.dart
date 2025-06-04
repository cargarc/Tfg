import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/service/auth_serivce.dart';
import 'package:pie_chart/pie_chart.dart';

class Checkhours extends StatelessWidget {
  Checkhours({Key? key}) : super(key: key);

  final dataMap = <String, double>{"Horas trabajadas": 5};

  final colorList = <Color>[Colors.greenAccent];

  @override
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    // final User user = _authService.getCurrentUser();
    return Scaffold(
      appBar: AppBar(title: Text("Chesck Hours")),
      body: FutureBuilder(
        future: _authService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final User user = snapshot.data as User;
            return Container(
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
                totalValue: user.contadorHoras.toDouble(),
                animationDuration: const Duration(milliseconds: 800),
              ),
            );
          }
        },
      ),
    );
  }
}
