import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Pie extends StatefulWidget {
  const Pie({super.key});

  @override
  State<Pie> createState() => _PieState();
}

class _PieState extends State<Pie> {
  Map<String, double> dataMap = {
    "Carbon diaoxide": 5,
    "carbon monoxide": 3,
    "Ammonia": 2,
    "Sulpher diaoxide": 2,
  };

  final gradientList = <List<Color>>[
    const [
      Color.fromRGBO(156, 4, 146, 1),
      Color.fromRGBO(238, 81, 235, 1),
    ],
    const [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    const [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    const [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PieChart(
        dataMap: dataMap,
        animationDuration: const Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width /2,
        initialAngleInDegree: 0,
        ringStrokeWidth: 20,
        gradientList: gradientList, // Add the gradientList here
        legendOptions: const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 1,
        ),
      ),
    );
  }
}
