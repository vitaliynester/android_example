import 'package:flutter/material.dart';

class PersonalModel {
  int id;
  String lastName;
  String firstName;
  String imgUrl;
  String phone;

  PersonalModel({
    @required this.id,
    @required this.lastName,
    @required this.firstName,
    @required this.imgUrl,
    @required this.phone,
  });

  PersonalModel.fromJson(Map<String, dynamic> json) {
    this.id = _getValue(json, 'id') ?? 0;
    this.lastName = _getValue(json, 'last_name') ?? "";
    this.firstName = _getValue(json, 'first_name') ?? "";
    this.imgUrl = _getValue(json, 'photo_200') ?? "";
    this.phone = _getValue(json, 'mobile_phone') ?? "";
  }

  Map<String, dynamic> toJson() {
    var result = Map<String, dynamic>();
    result['id'] = id;
    result['last_name'] = lastName;
    result['first_name'] = firstName;
    result['photo_200'] = imgUrl;
    result['mobile_phone'] = phone;
    return result;
  }

  dynamic _getValue(Map<String, dynamic> json, String key) {
    try {
      return json[key];
    } catch (e) {
      return null;
    }
  }
}
