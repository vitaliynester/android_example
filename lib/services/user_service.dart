import 'dart:convert';

import 'package:android_tutorial/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future saveUser(UserModel user) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  static Future<UserModel> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var userRow = prefs.getString('user');
    if (userRow == null || userRow.isEmpty) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(userRow));
  }
}
