
import 'package:flutter/material.dart';

class AlertSystemScreen extends StatefulWidget {
  const AlertSystemScreen({super.key});

  @override
  State<AlertSystemScreen> createState() => _AlertSystemScreenState();
}

class _AlertSystemScreenState extends State<AlertSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text("Alert Notification System.!",style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.w500
                ),),
                 Spacer(),
                Icon(Icons.notification_important_rounded,color: Colors.red,size: 100,)
              ],
            ),
          ),
        ),
    );
  }
}