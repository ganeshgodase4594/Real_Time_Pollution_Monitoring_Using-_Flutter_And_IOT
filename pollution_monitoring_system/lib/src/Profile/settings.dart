import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pollution_monitoring_system/src/Profile/edit_profile.dart';
import 'package:pollution_monitoring_system/src/Profile/help.dart';

class SettingsModule extends StatefulWidget {
  const SettingsModule({super.key});

  @override
  State<SettingsModule> createState() => _SettingsModuleState();
}

class _SettingsModuleState extends State<SettingsModule> {
  bool flag = true;
  final TextEditingController nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              //editProfile();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AuthenticationSignUp() ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 240, 240),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: const Icon(Icons.edit_outlined),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(
                    flex: 9,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 40,
                      )),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Your navigation logic here
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              RatingBar.builder(
                                  initialRating: 0,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    switch (index) {
                                      case 0:
                                        return const Icon(
                                          Icons.sentiment_very_dissatisfied,
                                          color: Colors.red,
                                        );
                                      case 1:
                                        return const Icon(
                                          Icons.sentiment_dissatisfied,
                                          color: Colors.redAccent,
                                        );
                                      case 2:
                                        return const Icon(
                                          Icons.sentiment_neutral,
                                          color: Colors.amber,
                                        );
                                      case 3:
                                        return const Icon(
                                          Icons.sentiment_satisfied,
                                          color: Colors.lightGreen,
                                        );
                                      case 4:
                                        return const Icon(
                                          Icons.sentiment_very_satisfied,
                                          color: Colors.green,
                                        );
                                    }
                                    return const Icon(Icons
                                        .star); // default case, should not be reached
                                  },
                                  onRatingUpdate: (double value) {}),
                              const SizedBox(height: 180),
                              ElevatedButton(
                                
                                  style: const ButtonStyle(
                                    
                                    elevation: MaterialStatePropertyAll(5),
                                    backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 228, 221, 221))
                                  ),
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('FeedBack'),
                                          content: const Text(
                                              'Thanks for your Valuable feedback'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: const Icon(Icons.rate_review_outlined),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Rate App",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(
                      flex: 9,
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 55,
                      width: 42,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Icon(Icons.help_outline_rounded),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  const Text(
                    "help",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(
                    flex: 9,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ChatPage()));
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
