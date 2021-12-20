import 'dart:convert';

import 'package:android_tutorial/models/models.dart';
import 'package:android_tutorial/services/services.dart';

class VKService {
  static String authUrl =
      "https://oauth.vk.com/authorize?client_id=8031015&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.131&state=123456";

  static Future<List<FriendModel>> getFriends() async {
    var user = await UserService.getUser();
    if (user == null) {
      return [];
    }
    var params = {
      'fields': 'contacts',
      'access_token': user.token,
      'v': '5.131',
    };
    var url = 'https://api.vk.com/method/friends.get';
    var response = await HttpService.get(url, params);

    var data = (jsonDecode(response)['response']['items'] as List);
    var result = data.map((e) => FriendModel.fromJson(e)).toList();
    return result;
  }

  static Future<PersonalModel> getPersonal({int id = 0}) async {
    var user = await UserService.getUser();
    if (user == null) {
      return null;
    }
    var params = Map<String, String>();
    params = {
      'user_ids': id == 0 ? user.id.toString() : id.toString(),
      'fields': 'photo_200, contacts',
      'access_token': user.token,
      'v': '5.131',
    };
    try {
      var url = 'https://api.vk.com/method/users.get';
      var response = await HttpService.get(url, params);

      var data = jsonDecode(response)['response'][0];
      var result = PersonalModel.fromJson(data);
      return result;
    } catch (e) {
      return null;
    }
  }
}
