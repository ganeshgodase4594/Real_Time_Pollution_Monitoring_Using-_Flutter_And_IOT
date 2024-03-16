import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pollution_monitoring_system/src/Profile/settings.dart';
import 'package:pollution_monitoring_system/src/authentication/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatelessWidget {
  const WhatsAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   _buildBottomSheet(context);
    // });

    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding:const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                const Spacer(flex: 2,),
                const Text("Profile",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
                const Spacer(flex: 1,),
                TextButton(
                  onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
                  child: const Text("LogOut", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),))
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ProfileAvatar(
                  size: 140,
                  hasEditButton: true,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              height: 700,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: const HomeScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.0), // Adjust the horizontal spacing
                child: Tab(
                  child: Text(
                    "Details",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0), // Adjust the horizontal spacing
                child: Tab(
                  child: Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0), // Adjust the horizontal spacing
                child: Tab(
                  child: Text(
                    "About",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SingleChildScrollView(child: DetailsScreen()),
                CallsScreen(),
                AboutScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatefulWidget {
  final double size;
  final bool hasEditButton;

  const ProfileAvatar({
    super.key,
    required this.size,
    this.hasEditButton = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.size / 2),
          child: _selectedImage != null
              ? Image.file(
                  File(_selectedImage!.path),
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: widget.size,
                  height: widget.size,
                  color: Colors.grey,
                ),
        ),
        if (widget.hasEditButton)
          Card(
            elevation: 5,
            color: Colors.white,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
            child: Container(
              height: 44,
              margin: const EdgeInsets.only(bottom: 0, right: 0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:Colors.white,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: _pickImage,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "userName",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 16.0, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                    color: Colors.black54, // Set text color
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Card(
            elevation: 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 238, 239),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Aditya jitendra Kaldhone",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 18.0, // Set the font size
                                fontWeight:
                                    FontWeight.bold, // Set the font weight
                                color: Colors.black, // Set text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Email",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 16.0, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                    color: Colors.black54, // Set text color
                  ),
                ),
              ),
            ],
          ),
          Card(
            elevation: 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 238, 239),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "adityaKaldhone1357@gmail.com",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 17.0, // Set the font size
                                fontWeight:
                                    FontWeight.bold, // Set the font weight
                                color: Colors.black, // Set text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            elevation: 0,
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  "Phone",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16.0, // Set the font size
                      fontWeight: FontWeight.bold, // Set the font weight
                      color: Colors.black54, // Set text color
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color:  Color.fromARGB(255, 235, 238, 239),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "9653415546",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 17.0, // Set the font size
                                fontWeight:
                                    FontWeight.bold, // Set the font weight
                                color: Colors.black, // Set text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "DOB",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 16.0, // Set the font size
                    fontWeight: FontWeight.bold, // Set the font weight
                    color: Colors.black54, // Set text color
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Card(
            elevation: 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 238, 239),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "06/08/2002",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 17.0, // Set the font size
                                fontWeight:
                                    FontWeight.bold, // Set the font weight
                                color: Colors.black, // Set text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            
          )
          )
      ],
    );
  }
}

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return const SettingsModule();
  }
}
