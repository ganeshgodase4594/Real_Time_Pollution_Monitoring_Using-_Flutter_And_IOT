import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_monitoring_system/src/Profile/profile.dart';
import 'package:pollution_monitoring_system/src/taskbar/taskmain.dart';

class AuthenticationSignUp extends StatefulWidget {
  const AuthenticationSignUp({super.key});

  

  @override
  State<AuthenticationSignUp> createState() => _AuthenticationSignUpState();
}

class AuthenticationAppModel {
  String name;
  String email;
  String phone;
  String dob;
  String address;
  AuthenticationAppModel(
      {required this.name,
      required this.email,
      required this.dob,
      required this.phone,
      required this.address});
}

//credential profile
List credentialList = [];


class _AuthenticationSignUpState extends State<AuthenticationSignUp> {
  
  //Save all data in controllers
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailNode = FocusNode();

  final TextEditingController _dobController = TextEditingController();
  final FocusNode _dobNode = FocusNode();

  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneNode = FocusNode();

  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressNode = FocusNode();

  
  void date() async {
    DateTime? datetime = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2030));
    if (datetime != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(datetime);
      });
    }
  }



  //GLOBAL KEYS
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Register function to add credential
  void registerCredential() {
    print("hiii");
    
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _dobController.text.isEmpty || _phoneController.text.isEmpty || _addressController.text.isEmpty   ) {
      _formKey.currentState?.validate();
    } else {
      credentialList.add(AuthenticationAppModel(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          dob: _dobController.text,
          address: _addressController.text
        )
        
      );
         
   //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TaskMain()));
    Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 10,
          flexibleSpace: SizedBox(
              height: 80,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const WhatsAppHome()));
                },
                child: const Row(
                  children: [
                     SizedBox(
                      width: 30,
                    ),
                    Text("Edit Details",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))
                  ],
                ),
              ))),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Text(
                        "Name",
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromRGBO(1, 1, 1, 1)),
                      ),
                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameNode,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.account_circle_rounded),
                            suffixIconColor:
                                Color.fromARGB(255, 226, 217, 217),
                            
                            enabled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: .7,
                                    color: Color.fromRGBO(0, 139, 148, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: .7,
                                    color: Color.fromRGBO(0, 139, 148, 1)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*all fields are fill mandatory";
                          }else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Email",
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromRGBO(1, 1, 1, 1)),
                      ),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailNode,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  width: .7,
                                  color: Color.fromRGBO(0, 139, 148, 1))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  width: .7,
                                  color: Color.fromRGBO(0, 139, 148, 1))),
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('@', style: TextStyle(fontSize: 20, color: Colors.grey),),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*all fields are fill mandatory";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Phone Number",
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromRGBO(1, 1, 1, 1)),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        focusNode: _phoneNode,
                                          
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.phone),
                          suffixIconColor: Colors.grey,
                            enabled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: .7,
                                    color: Color.fromRGBO(0, 139, 148, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: .7,
                                    color: Color.fromRGBO(0, 139, 148, 1))),
                                      
                                    ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*all fields are mandatory";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Date of Birth",
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromRGBO(1, 1, 1, 1)),
                      ),
                      TextFormField(
                        onTap: () {
                          date();
                        },
                        controller: _dobController,
                        focusNode: _dobNode,
                        decoration: const InputDecoration(
                          
                          suffixIcon: Icon(Icons.calendar_today,),
                          suffixIconColor: Colors.grey,
                           enabled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: .7,
                                    color: Color.fromRGBO(0, 139, 148, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: .7,
                                    color: Color.fromRGBO(0, 139, 148, 1)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*all fields are mandatory";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Address",
                        style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color.fromRGBO(1, 1, 1, 1)),
                      ),
                      TextFormField(
                        controller: _addressController,
                        focusNode: _addressNode,
                        keyboardType: TextInputType.visiblePassword,
                        
                        decoration: const InputDecoration(
                          
                            enabled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: 0.7,
                                    color: Color.fromRGBO(0, 139, 148, 1))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    width: .7,
                                    color: Color.fromRGBO(0, 139, 148, 1)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*all fields are mandatory";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 60,)
            ],
          ),
        ),
      ),
      
      floatingActionButton: SizedBox(
          width: 200,
          height: 50, // Adjust the width as needed
          child: FloatingActionButton(
            onPressed: () {
              registerCredential();
              
             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const WhatsAppHome()));
            },
            elevation: 3.0,
            backgroundColor:const  Color.fromARGB(255, 242, 237, 237), // Adjust the elevation as needed
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)) // Half of the width/height
            ),
            child:const Text("Proceed",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        
    );
  }
}
