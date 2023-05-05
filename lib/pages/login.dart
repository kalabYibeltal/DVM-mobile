import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../datamodel.dart';
import 'package:dvm/pages/choose_machine.dart';
// import 'package:requests/requests.dart';

import 'package:dvm/pages/signup.dart';


void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  LoginStateful(),
      ),
      theme: ThemeData(
          fontFamily: 'Feather',
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Color(0xFFAFAFAF),
          )),
    );
  }
}

class LoginStateful extends StatefulWidget {
  const LoginStateful({Key? key}) : super(key: key);

  @override
  State<LoginStateful> createState() => _LoginStatefulState();
}

class _LoginStatefulState extends State<LoginStateful> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorEmail = ""; // the error message that shows when the user inputs wrong information
  String? errorPassword = "";
  String loginButtonText = "LOGIN";

  Future<returnedUser> LogUser(String email, String password) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://dvm.onrender.com/login');
    var body = {'email': email, 'password': password};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    log(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map result = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp

    print(resBody);
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      returnedUser data = returnedUser(
        name: result['user']['name'],
        email: result['user']['email'],
        phoneNumber: result['user']['phoneNumber'],
        balance: result['user']['balance'],
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

    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 5),
              child: Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
            ),

            SizedBox(height: height * 0.01),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
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
                )),

            SizedBox(
              height: height * 0.02,
            ),
            Container(
                height: height * 0.09,
                padding: const EdgeInsets.fromLTRB(130, 15, 130, 0),
                child: ElevatedButton(
                    // width: 5,
                    child: Text(loginButtonText,
                      style: TextStyle(fontSize: 20 ),
                    ),

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;
                      setState(() {
                        loginButtonText = "Loading...";
                      });

                      returnedUser data = await LogUser(email, password);
                      if (data.errors != null) {
                        setState(() {

                          // here depending on the return value "data" the system recognizes
                          // whether the user is a driver,police or admin and notify user if email or password is wrong
                          if (data.errors!['email'] != null) {
                            errorEmail = data.errors!['email'];
                            errorPassword = data.errors!['password'];
                            loginButtonText = "LOGIN";
                          }
                        });
                      }
                     else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseMachine(data: data)),
                              (Route<dynamic> route) => false,
                        );
                      }
                    })),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
              child: Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                const Text(
                  'Don\'t have account?',
                  style: TextStyle(
                    color: Color(0xFFAFAFAF),
                  ),
                ),
                SizedBox(width: 10.0),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF2CACE7),
                    ),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            SizedBox(height: height * 0.05),
          ],
        ));
  }
}
