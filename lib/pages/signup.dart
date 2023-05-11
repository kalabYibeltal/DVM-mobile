// import 'dart:io';

import 'dart:convert';
import 'dart:developer';

import 'package:dvm/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../datamodel.dart';

void main() => runApp(const Signup());

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: _title,
      home: Scaffold(
        body: const SignupStateful(),
      ),
      theme: ThemeData(
          fontFamily: 'Feather',
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.grey[400],
          )),
    );
  }
}

class SignupStateful extends StatefulWidget {
  const SignupStateful({Key? key}) : super(key: key);

  @override
  State<SignupStateful> createState() => _SignupStatefulState();
}

class _SignupStatefulState extends State<SignupStateful> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController repeatedPasswordController = TextEditingController();
  String? errorEmail = ""; // the error message that shows when the user inputs wrong information
  String? errorPassword = "";
  String? errorName = "";
  String btnTxt = "SIGNUP";


  Future<returnedUser> signUser(String name, String email,String password,
      String phoneNumber) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://dvm-dq1y.onrender.com/signup');
    var body = {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,

    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    Map result = jsonDecode(resBody);

    if (res.statusCode == 201 || res.statusCode == 300) {
      returnedUser data = returnedUser(
        name: result['user']['name'],
        email: result['user']['email'],
        phoneNumber: result['user']['phoneNumber'],
        balance: result['user']['role'],
        id: result['user']['_id'],
      );
      return data;
    } else {
      returnedUser data = returnedUser(errors: Map.from(result['errors']));
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print(height);
    // print(width);

    return Container(
      //height: height * 0.1, //height to 10% of screen height, 100/10 = 0.1
      //width: width * 0.7, //width t 70% of screen width
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Image.asset(
                  'assets/logo.png',
                  height: height * 0.15, //height to 9% of screen height,
                  width: width * 0.15,
                ),
              ),
              SizedBox(
                height: height * 0.0, //height to 9% of screen height,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: nameController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'name',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "$errorName",
                  style: TextStyle(color: Colors.red, fontSize: 10.0),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: emailController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'email',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "$errorEmail",
                  style: TextStyle(color: Colors.red, fontSize: 10.0),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'phone number',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE4E4E4),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF2CACE7),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'password',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "$errorPassword",
                  style: TextStyle(color: Colors.red, fontSize: 10.0),
                ),
              ),


              SizedBox(
                height: height * 0.02,
              ),
              Container(
                  height: height * 0.09,
                  padding: const EdgeInsets.fromLTRB(130, 20, 130, 0),
                  child: ElevatedButton(
                    child: Text('$btnTxt',
                      style: TextStyle(fontSize: 20, ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      setState(() {
                        btnTxt = "Registering...";
                      });
                      String name = nameController.text;
                      String email = emailController.text;
                      String phoneNumber = phoneNumberController.text;
                      String password = passwordController.text;

                      returnedUser data =
                      await signUser(name, email, password, phoneNumber );

                      String user = "user";
                      print(data.name);
                      if (data.errors == null){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                              (Route<dynamic> route) => false,
                        );
                      }
                      else{
                        setState(() {
                          btnTxt = "SIGNUP";
                          errorName = data.errors!["name"];
                          errorEmail = data.errors!['email'];
                          errorPassword = data.errors!['password'];
                        });
                      }


                    },
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                child: Center(
                  child: Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFAFAFAF),
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Color(0xFFAFAFAF),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Color(0xFF2CACE7),
                      ),
                    ),
                    onPressed: () {
                      //signup screen
                      // Navigator.pushReplacementNamed(context, '/');
                      // Navigator.pushNamed(context, MaterialPageRoute(builder: (context) => Login()));

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(height: height * 0.02),
            ],
          )),
    );
  }
}
