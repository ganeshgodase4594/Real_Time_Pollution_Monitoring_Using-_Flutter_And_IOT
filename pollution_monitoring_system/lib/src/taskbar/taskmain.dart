import 'package:flutter/material.dart';
import 'package:pollution_monitoring_system/src/Profile/profile.dart';
import 'package:pollution_monitoring_system/src/dashboard/Notification.dart';
import 'package:pollution_monitoring_system/src/dashboard/dashboard.dart';
import 'package:pollution_monitoring_system/src/search/ai.dart';
import 'package:pollution_monitoring_system/src/taskbar/taskbar.dart';

class TaskMain extends StatefulWidget {
  static const title = 'salomon_bottom_bar';

  const TaskMain({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TaskMain> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TaskMain.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
       
        body: _buildPage(_currentIndex),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() {
            _currentIndex = i;
          }),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Notifications
            SalomonBottomBarItem(
              icon: const Icon(Icons.notification_add),
              title: const Text("Notifications"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
   Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const DashBoard();
      case 1:
        return const AlertSystemScreen();
      case 2:
        return  const Home();
      case 3:
        return const WhatsAppHome();
      default:
        return Container();
    }
  }
}
