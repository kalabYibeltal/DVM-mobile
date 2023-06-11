//import 'package:flutter/cupertino.dart';
import 'package:dvm/datamodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dvm/pages/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:dvm/pages/history.dart';
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
        Row(
          children: [
            SizedBox(
              width: 16, //height to 9% of screen height,
            ),
            Container(
              width: 120,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyListViewPage()),
                    // (Route<dynamic> route) => false,
                  );
                },
                child: Center(
                  child: Column (
                    children: [
                      Text('History',
                        style: TextStyle(fontSize: 25.0, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
              child: Text("Balance:  ${User.balance}",
                style: TextStyle(fontSize: 25.0, color: Colors.green),
              ),
            ),
          ],
        ),

        SizedBox(
          height: 50, //height to 9% of screen height,
        ),
        Row(
          children: [
            SizedBox(
              width: 16, //height to 9% of screen height,
            ),

             Container (
                  width: 180,
                  height: 250,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                      ),
                      child: Center(
                        child: Column (
                          children: [
                            SizedBox(
                              height: 20, //height to 9% of screen height,
                            ),
                            Image.asset('assets/chips.png'),
                            Text('Sun Chips',
                              style: TextStyle(fontSize: 25.0, color: Colors.black),
                            ),
                            Center(child: Text('15 Br',
                              style: TextStyle(fontSize: 20.0, color: Colors.black),
                            )),
                          ],
                        ),
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
                            var result3 = await giveItem(1);
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
              width: 12, //height to 9% of screen height,
            ),
            Container (
                width: 180,
                height: 250,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                      // Add other style properties as needed
                    ),
                    child: Center(
                      child: Column (
                        children: [
                          SizedBox(
                            height: 20, //height to 9% of screen height,
                          ),
                          Image.asset('assets/coca.png'),
                          Text('Coca',
                            style: TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                          Center(child: Text('20 Br',
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
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

                          var result = await purchaseItem('coca',User, Machine, price);
                          var result2 = await destockmachine("coca",Machine,price);
                          var result3 = await giveItem(2);

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
          height: 10, //height to 9% of screen height,
        ),
        Row(
          children: [
            SizedBox(
              width: 16, //height to 9% of screen height,
            ),
            Container (
                width: 180,
                height: 250,

                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                      // Add other style properties as needed
                    ),
                    child: Center(
                      child: Column (
                        children: [
                          SizedBox(
                            height: 20, //height to 9% of screen height,
                          ),
                          Image.asset('assets/rock.png'),
                          Text('Rock',
                            style: TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                          Center(child: Text('10 Br',
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
                          )),
                        ],
                      ),
                    ),

                    onPressed: () async {
                      String item = 'rock';
                      int price = widget.machine.items![item]["price"];
                      int count = widget.machine.items![item]["stock"];
                      if (User.balance! >= price){
                        if (count > 0){
                          User.balance = User.balance! - price;
                          Machine.items![item]["stock"] = Machine.items![item]["stock"] - 1;

                          var result = await purchaseItem('rock',User, Machine, price);
                          var result2 = await destockmachine("rock",Machine,price);
                          var result3 = await giveItem(3);

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
                width: 180,
                height: 250,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                      // Add other style properties as needed
                    ),
                    child: Center(
                      child: Column (
                        children: [
                          SizedBox(
                            height: 20, //height to 9% of screen height,
                          ),
                          Image.asset('assets/abuwalad.png'),
                          Text('Abu walad',
                            style: TextStyle(fontSize: 25.0, color: Colors.black),
                          ),
                          Center(child: Text('500 Br',
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
                          )),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      String item = 'abuwalad';
                      int price = widget.machine.items![item]["price"];
                      int count = widget.machine.items![item]["stock"];
                      if (User.balance! >= price){
                        if (count > 0){
                          User.balance = User.balance! - price;
                          Machine.items![item]["stock"] = Machine.items![item]["stock"] - 1;
                          print(Machine.items);
                          var result = await purchaseItem('abuwalad',User, Machine, price);
                          var result2 = await destockmachine("abuwalad",Machine,price);
                          var result3 = await giveItem(4);

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
          height: 15, //height to 9% of screen height,
        ),
       Container(
         padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
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
    var url = Uri.parse('https://dvm-dq1y.onrender.com/updatebalance');
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
    var url = Uri.parse('https://dvm-dq1y.onrender.com/vmachine/buyitem_post');
    var body = {'machineid': machine.id, 'itemname': item};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res2 = await req.send();

    return "Transaction successful.";
    // return failure
  }

  Future<String> giveItem(int val) async {
    // return item;
    // access api
    // var headersList = {
    //   'Accept': '*/*',
    //   'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    //   'Content-Type': 'application/json'
    // };
    //
    //
    // // decrease amount from user balance
    print("giving item");
    print(val);

    Response response;
    var dio = Dio();


    response = await dio.post("http://192.168.29.218:8080/object/", data: {
    'val': val,
    });
    // print(response.data['verdict']);

    return response.data;
    // return failure
  }
}

