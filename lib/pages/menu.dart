import 'package:dvm/datamodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dvm/pages/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dvm/pages/choose_machine.dart';
import 'package:dvm/pages/buildings.dart ';
import 'package:dvm/pages/feedback.dart';
import 'package:dvm/pages/nearby.dart';


class Menu extends StatefulWidget {
  final returnedUser data;
  const Menu({Key? key, required this.data}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'what do you want?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('What is on your mind...',
            style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,


        ),

        body: Container(
          padding: const EdgeInsets.fromLTRB(25, 55, 25, 10),
          child:
          // Column(
          //   children: [
              GridView.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: [
                  ElevatedButton(
                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseMachine(data: widget.data)),
                              // (Route<dynamic> route) => false,
                        );
                      },

                      child: Center(
                        child: Column (
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                child: Image.asset("assets/purchase.png")),
                            SizedBox(
                              height: 20, //height to 9% of screen height,
                            ),
                            Text('Purchase',
                              style: TextStyle(fontSize: 25.0, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseLocation()),
                            // (Route<dynamic> route) => false,
                      );
                    },
                    child: Center(
                      child: Column (
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/building.png")),
                          SizedBox(
                            height: 25, //height to 9% of screen height,
                          ),
                          Center(
                            child: Text('Registerd buildings',
                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationWidget()),
                            // (Route<dynamic> route) => false,
                      );
                    },
                      child: Center(
                      child: Column (
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/nearby.png")),
                          SizedBox(
                            height: 25, //height to 9% of screen height,
                          ),
                          Text('Nearby machines',
                            style: TextStyle(fontSize: 17.0, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedbackComponent()),
                            // (Route<dynamic> route) => false,
                      );
                    },
                    child: Center(
                      child: Column (
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/feedback.png")),
                          SizedBox(
                            height: 20, //height to 9% of screen height,
                          ),
                          Text('feedback',
                            style: TextStyle(fontSize: 25.0, color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          //   ],
          // ),

        ),
      ),
    );
  }
}
