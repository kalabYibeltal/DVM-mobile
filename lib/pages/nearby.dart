import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dvm/pages/login.dart';
import 'package:url_launcher/url_launcher.dart';


class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  double _latitude =  0;
  double _longitude = 0;
  String building = "Zefmesh";
  double distance = 7.2;

  Future<void> _getLocation() async {
    try {
      PermissionStatus status = await Permission.location.request();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);


      setState(() {
        _latitude = position.latitude.toDouble();
        _longitude = position.longitude.toDouble();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Object> getbuilding(double lon, double lat) async {
    Response response;
    var dio = Dio();

    print(lat);
    print(lon);
    try {
      response = await dio.post("https://dvm-dq1y.onrender.com/build/getshort", data:{'lon': lon, 'lat': lat});
      print(response.data);
      double trimmedNumber = double.parse(response.data["ans"].toStringAsFixed(2));
      print(trimmedNumber);
      setState(() {
        building = response.data["area"];
        distance = trimmedNumber;
      });
      return response.data.area;

    }catch (e) {
        print(e);
        return "Transaction unsuccessful.";
      }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'what do you want?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      appBar: AppBar(
      title: Text('Get the nearest Machine',
      style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.black),
    ),
    centerTitle: true,
    backgroundColor: Colors.green,

    ),

    body:  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          ElevatedButton(
            onPressed: () async{
              _getLocation();
              // print(_latitude);
              // print(_longitude);
              // print("*******************************************");
               Object res = await getbuilding(_longitude, _latitude);
              // setState(() {
              //   building = res["area"];
              //   distance = res["ans"];
              // });
            },
            child: Text('Get nearest Building'),
          ),
          SizedBox(height: 16.0),
          Text('Building: $building', style: TextStyle(fontSize: 25)),
          SizedBox(height: 8.0),
          Text('Distance: $distance km', style: TextStyle(fontSize: 25)),
        ],
      ),
    )
    ));
  }
}
