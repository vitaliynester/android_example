import 'package:flutter/material.dart';

class UserModel {
  int id;
  String token;

  UserModel({@required this.id, @required this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.token = json['token'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = Map<String, dynamic>();
    result['id'] = id;
    result['token'] = token;
    return result;
  }
}
