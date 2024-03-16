import 'package:flutter/material.dart';
import 'package:pollution_monitoring_system/src/dashboard/charts/columnchart.dart';
import 'package:pollution_monitoring_system/src/dashboard/charts/piechart.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            
            children: [
              Card(
                elevation: 30, // Adjust the elevation as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: ColumnChart(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 30, // Adjust the elevation as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius as needed
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Pie(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.deepOrange,
                width: double.infinity,
                height: 400,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.deepPurple,
                width: double.infinity,
                height: 400,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.pinkAccent,
                width: double.infinity,
                height: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
