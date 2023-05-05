// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

UserModel? dataModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String dataModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  UserModel({
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.id,
    this.balance,
  });

  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? id;
  int? balance;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    password: json["password"],
    id: json["id"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "id": id,
    "balance": balance,
  };
}

class returnedUser {
  Map<String, String>? errors;

  String? id;
  String? name;
  String? email;
  int? balance;
  String? phoneNumber;   //when a phone number is obtained from the server

  //here is where all the information received from the server is stored

  returnedUser({this.email, this.name, this.balance, this.phoneNumber, this.errors, this.id});
}


class MachineModel {
  MachineModel({
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.id,
    this.balance,
  });

  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? id;
  int? balance;

  factory MachineModel.fromJson(Map<String, dynamic> json) => MachineModel(
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    password: json["password"],
    id: json["id"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "id": id,
    "balance": balance,
  };
}
class Items {
  Map? item1;
  Items({this.item1});
}

class returnedMachine {
  String? errors;

  String? id;
  String? name;
  int? numberofitems;
  Map? items;
  int? income;  //when a phone number is obtained from the server

  //here is where all the information received from the server is stored

  returnedMachine({this.numberofitems, this.name, this.income,  this.errors, this.id, this.items});
}



