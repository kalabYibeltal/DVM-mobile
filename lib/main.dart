import 'package:dvm/pages/buyitem.dart';
import 'package:flutter/material.dart';
//import 'dart:ui';

import 'package:dvm/pages/login.dart';
import 'package:dvm/pages/signup.dart';
import 'package:dvm/pages/choose_machine.dart';
import 'package:dvm/pages/buyitem.dart';



void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/signup': (context) => Signup(),
    },
    theme: ThemeData(
        fontFamily: 'Feather',
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Color(0xFFAFAFAF),
        )),
  ));
}
