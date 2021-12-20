import 'package:flutter/material.dart';

class FriendModel {
  int id;
  String lastName;
  String firstName;
  String mobilePhone;

  FriendModel({
    @required this.id,
    @required this.lastName,
    @required this.firstName,
    @required this.mobilePhone,
  });

  FriendModel.fromJson(Map<String, dynamic> json) {
    this.id = _getValue(json, 'id') ?? 1;
    this.lastName = _getValue(json, 'last_name') ?? "";
    this.firstName = _getValue(json, 'first_name') ?? "";
    this.mobilePhone = _getValue(json, 'mobile_phone') ?? "";
  }

  dynamic _getValue(Map<String, dynamic> json, String key) {
    try {
      return json[key];
    } catch (e) {
      return null;
    }
  }
}
