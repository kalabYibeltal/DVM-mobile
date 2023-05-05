//import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:dvm/datamodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dvm/pages/buyitem.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'login.dart';


class ChooseMachine extends StatefulWidget {
  final returnedUser data;
  const ChooseMachine({Key? key, required this.data}) : super(key: key);

  @override
  _ChooseMachineState createState() => _ChooseMachineState();
}

class _ChooseMachineState extends State<ChooseMachine> {

  TextEditingController machineController = TextEditingController();
  String? errormachine = ""; // the error message that shows when the user inputs wrong information
  String? errormachine2 = "";
  String chooseButtonText = "Choose Machine ID";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var getResult = 'QR Code Result';

    return
      new Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 70, 20, 5),
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
                  controller: machineController,
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
                    labelText: 'machine id',
                    labelStyle: TextStyle(
                      color: Color(0xFFAEAEAE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "$errormachine",
                  style: TextStyle(color: Colors.red, fontSize: 10.0),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                  height: height * 0.09,
                  width: width * 0.5,
                  padding: const EdgeInsets.fromLTRB(104, 15, 104, 0),
                  child: ElevatedButton(
                      child: Text(chooseButtonText,
                        style: TextStyle(fontSize: 16, color: Colors.red ),
                      ),

                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        backgroundColor: Colors.greenAccent,
                      ),
                      onPressed: () async {
                        String result = await machineController.text;
                        returnedMachine machine = await Logmachine(result);
                        if (machine.errors != null){
                        setState(() {
                        errormachine = "Unknown vending machine";
                        });
                        }
                        else{
                        Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                        builder: (context) => BuyitemPage(user: widget.data, machine: machine)),
                        (Route<dynamic> route) => false,
                        );
                        }
                        }
                      )),

              SizedBox(
                height: height * 0.1,
              ),


              Container(
                  height: height * 0.09,
                  width: width * 0.5,
                  padding: const EdgeInsets.fromLTRB(110, 15, 110, 0),
                  child: ElevatedButton(
                      child: Text("Scan QR Code",
                        style: TextStyle(fontSize: 18, color: Colors.blue ),

                      ),

                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        backgroundColor: Colors.grey[400],
                      ),
                      onPressed: () async {
                        var result = await scanQRCode();
                        // print(result);
                        // print("cdobjectbnbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
                        returnedMachine machine = await Logmachine(result);
                        // print(machine.errors);
                        // print("objectbnbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
                        if (machine.errors != null){
                          setState(() {
                            errormachine2 = "Unknown vending machine";
                          });
                        }
                        else{
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuyitemPage(user: widget.data, machine: machine)),
                              (Route<dynamic> route) => false,
                        );
                        }
                        }
                      )),
              Center(
                child: Text(
                  "$errormachine2",
                  style: TextStyle(color: Colors.red, fontSize: 10.0),
                ),
              ),


            ],
          )),
      );


  }
  Future<returnedMachine> Logmachine(String name) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    var url = Uri.parse('https://dvm.onrender.com/vmachine/machinelogin');
    var body = {'name': name};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    log(req.body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    Map result = jsonDecode(
        resBody); // accepts the data from the server and maps it onto temp

   print(res.statusCode);
    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 300) {
      returnedMachine data = returnedMachine(
        name: result['machine']['name'],
        income: result['machine']['income'],
        numberofitems: result['machine']['numberofitems'],
        items: result['machine']['items'],
        id: result['machine']['_id'],
      );

      return data;
    } else {
      returnedMachine data = returnedMachine(errors: result['errors']);
      return data;
    }

  }

  Future<String> scanQRCode() async {
    var result = 'QR Code Result';
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return "Failed";

      setState(() {
        result = qrCode;
      });
      print("QRCode_Result:--");
      print(qrCode);
      return result;
    } catch(err) {
      return 'Failed to scan QR Code.';
    }

  }

}
