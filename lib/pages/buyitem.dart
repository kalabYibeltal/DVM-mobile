//import 'package:flutter/cupertino.dart';
import 'package:dvm/datamodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dvm/pages/login.dart';
import 'package:url_launcher/url_launcher.dart';

// void main() => runApp(DriverPage());

class BuyitemPage extends StatefulWidget {
  final returnedUser user;
  final returnedMachine machine;
  const BuyitemPage({Key? key, required this.user, required this.machine}) : super(key: key);
  @override
  _BuyitemPageState createState() => _BuyitemPageState();
}

class _BuyitemPageState extends State<BuyitemPage> {

  String mainTitle = "Home";
  String purchase = "Select an item";
  int balance = 0;
  int operation = 1;
  int operation2 = 1;
  late returnedUser User;
  late returnedMachine Machine;
  Color getcolor(c){
    if (c == 2){
      return Colors.red;
    }else if(c == 3){
      return Colors.green;
    }else{
      return Colors.black;
    }
  }
  Color getcolor2(c){
    if (c == 1){
      return Colors.white;
    }else{
      return Colors.green;
    }
  }
  @override
  void initState() {
    balance = widget.user.balance!;
    User = widget.user;
    Machine = widget.machine!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor:Colors.black,
      elevation: 3,
      title: Text(
        "Buy an item",
        style: TextStyle(color: Colors.white, fontSize: 25.0),
      ),
      centerTitle: true,
    ),
    body: Column(
      children: [
        SizedBox(
          height: 25, //height to 9% of screen height,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
          child: Text("balance:  ${User.balance}",
            style: TextStyle(fontSize: 25.0, color: Colors.green),
          ),
        ),
        SizedBox(
          height: 120, //height to 9% of screen height,
        ),
        Row(
          children: [
            SizedBox(
              width: 4, //height to 9% of screen height,
            ),
            Container (
              width: 200,
              height: 100,
              child: ElevatedButton(
                child: Center(
                  child: Column (
                    children: [
                      SizedBox(
                        height: 20, //height to 9% of screen height,
                      ),
                      Text('Coca',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Center(child: Text('5 Br',
                        style: TextStyle(fontSize: 20.0),
                      )),
                    ],
                  ),
                ),

                  onPressed: () async {
                    String item = 'coca';
                    int price = widget.machine.items![item]["price"];
                    int count = widget.machine.items![item]["stock"];
                    if (User.balance! >= price){
                      if (count > 0){
                        User.balance = User.balance! - price;
                        Machine.items![item]["stock"] = Machine.items![item]["stock"] - 1;

                        var result = await purchaseItem('moya',User, Machine, price);

                        setState(() {
                          purchase = result;
                            operation = 3;
                            operation2 = 1;
                        });
                      }
                      else {
                        setState(() {
                          purchase = "Insufficient stock in the machine";
                          operation = 2;
                        });
                      };

                    }
                    else {
                      setState(() {
                        purchase = "Insufficient balance";
                      operation = 2;
                        operation2 = 2;
                      });
                    };

                  }
              )
            ),
            SizedBox(
              width: 4, //height to 9% of screen height,
            ),
            Container (
                width: 200,
                height: 100,
                child: ElevatedButton(
                    child: Center(
                      child: Column (
                        children: [
                          SizedBox(
                            height: 20, //height to 9% of screen height,
                          ),
                          Text('Banana',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Center(child: Text('15 Br',
                            style: TextStyle(fontSize: 20.0),
                          )),
                        ],
                      ),
                    ),


                    onPressed: () async {
                      String item = 'banana';
                      int price = widget.machine.items![item]["price"];
                      int count = widget.machine.items![item]["stock"];
                      if (User.balance! >= price){
                        if (count > 0){
                          User.balance = User.balance! - price;
                          Machine.items![item]["stock"] = Machine.items![item]["stock"] - 1;

                          var result = await purchaseItem('moya',User, Machine, price);

                          setState(() {
                            purchase = result;
                              operation = 3;
                            operation2 = 1;
                          });
                        }
                        else {
                          setState(() {
                            purchase = "Insufficient stock in the machine";
                      operation = 2;
                          });
                        };

                      }
                      else {
                        setState(() {
                          purchase = "Insufficient balance";
                      operation = 2;
                          operation2 = 2;
                        });
                      };

                    }
                )
            ),
          ],
        ),
        SizedBox(
          height: 30, //height to 9% of screen height,
        ),
        Row(
          children: [
            SizedBox(
              width: 4, //height to 9% of screen height,
            ),
            Container (
                width: 200,
                height: 100,

                child: ElevatedButton(
                    child: Center(
                      child: Column (
                        children: [
                          SizedBox(
                            height: 20, //height to 9% of screen height,
                          ),
                          Text('Bread',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Center(child: Text('8 Br',
                            style: TextStyle(fontSize: 20.0),
                          )),
                        ],
                      ),
                    ),

                    onPressed: () async {
                      String item = 'bread';
                      int price = widget.machine.items![item]["price"];
                      int count = widget.machine.items![item]["stock"];
                      if (User.balance! >= price){
                        if (count > 0){
                          User.balance = User.balance! - price;
                          Machine.items![item]["stock"] = Machine.items![item]["stock"] - 1;

                          var result = await purchaseItem('moya',User, Machine, price);

                          setState(() {
                            purchase = result;
                              operation = 3;
                            operation2 = 1;
                          });
                        }
                        else {
                          setState(() {
                            purchase = "Insufficient stock in the machine";
                      operation = 2;
                          });
                        };

                      }
                      else {
                        setState(() {
                          purchase = "Insufficient balance";
                      operation = 2;
                          operation2 = 2;
                        });
                      };

                    }

                )
            ),
            SizedBox(
              width: 4, //height to 9% of screen height,
            ),
            Container (
                width: 200,
                height: 100,
                child: ElevatedButton(
                    child: Center(
                      child: Column (
                        children: [
                          SizedBox(
                            height: 20, //height to 9% of screen height,
                          ),
                          Text('Chips',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Center(child: Text('10 Br',
                            style: TextStyle(fontSize: 20.0),
                          )),
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                      // backgroundColor: ,
                    ),
                    onPressed: () async {
                      String item = 'chips';
                      int price = widget.machine.items![item]["price"];
                      int count = widget.machine.items![item]["stock"];
                      if (User.balance! >= price){
                        if (count > 0){
                          User.balance = User.balance! - price;
                          Machine.items![item]["stock"] = Machine.items![item]["stock"] - 1;

                          var result = await purchaseItem('chips',User, Machine, price);
                          var result2 = await destockmachine("chips",Machine,price);

                          setState(() {
                            purchase = result;
                              operation = 3;
                             operation2 = 1;
                          });
                        }
                        else {
                          setState(() {
                            purchase = "Insufficient stock in the machine";
                            operation = 2;

                          });
                        };

                      }
                      else {
                        setState(() {
                          purchase = "Insufficient balance";
                          operation = 2;
                          operation2 = 2;
                        });
                      };

                    }
                )
            ),
          ],
        ),
        SizedBox(
          height: 50, //height to 9% of screen height,
        ),
       Container(
         padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
         child: Center(
                child: Column(
                  children: [
                    Text(
                    purchase,
                    style: TextStyle(color: getcolor(operation), fontSize: 25.0)
                  ),
                    InkWell(
                        child: Text('You can also buy using CHAPA',
                          style: TextStyle(fontSize: 16, color: getcolor2(operation2) ),
                        ),
                        onTap: () => launch('https://checkout.chapa.co/checkout/web/payment/SC-pSfB0sN7ORnF')
                    ),

                  ])

         ),
       )
      ],
    )
  );

  Future<String> purchaseItem(String item,returnedUser user, returnedMachine machine, int price) async {
    // return item;
    // access api
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };


    // decrease amount from user balance
    var url = Uri.parse('https://dvm.onrender.com/updatebalance');
    var body = {'userid': user.id, 'newbalance': user.balance};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();


    return "Transaction successful.";
    // return failure
  }
  Future<String> destockmachine(String item, returnedMachine machine, int price) async {
    // return item;
    // access api
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    // deduct item from vending machine and increase income
    var url = Uri.parse('https://dvm.onrender.com/vmachine/buyitem_post');
    var body = {'machineid': machine.id, 'itemname': item};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res2 = await req.send();

    return "Transaction successful.";
    // return failure
  }
}

