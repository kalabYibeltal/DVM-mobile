import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class MyListViewPage extends StatefulWidget {
  @override
  _MyListViewPageState createState() => _MyListViewPageState();
}

class _MyListViewPageState extends State<MyListViewPage> {
  var inputData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Response response;
      var dio = Dio();

      response = await dio.post("https://dvm-dq1y.onrender.com/history", data: {
        'id': "6484c9f1ad2555ad737d9e06",
      });
      print(response.data);

      setState(() {
        inputData = response.data;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Purchase History',
          style: TextStyle(color: Colors.black, fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          Card(
            child: Text(
              "Total: ${inputData.isNotEmpty ? inputData[0][1] : ''}",
              style: TextStyle(fontSize: 26, color: Colors.redAccent),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: inputData.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SizedBox.shrink(); // Skip zeroth index
                }

                final item = inputData[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      item[0],
                      style: TextStyle(fontSize: 25),
                    ), // First string element
                    subtitle: Text(
                      item[1],
                      style: TextStyle(fontSize: 20),
                    ), // Second string element
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
