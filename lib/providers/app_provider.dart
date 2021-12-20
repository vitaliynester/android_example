import 'package:android_tutorial/models/models.dart';
import 'package:android_tutorial/services/services.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int index;

  UserModel user;
  PersonalModel personal;
  List<FriendModel> friends;

  AppProvider() {
    index = 0;
    friends = List<FriendModel>();
  }

  void updateIndex(int value) {
    index = value;
    notifyListeners();
  }

  void updateUser(UserModel value) {
    user = value;
    notifyListeners();
  }

  void updatePersonal(PersonalModel value) {
    personal = value;
    notifyListeners();
  }

  Future getForPage() async {
    PersonalModel result;
    if (personal == null) {
      result = await VKService.getPersonal(id: user?.id ?? 0);
      personal = result;
    } else {
      result = personal;
    }
    notifyListeners();
    return result;
  }

  Future getFriends() async {
    var db = new DatabaseService();
    var dataFromDb = await db.getFriendsFromDatabase();
    if (dataFromDb.isEmpty) {
      var result = await VKService.getFriends();
      for (var friend in result) {
        await db.insertToFriendDatabase(friend);
      }
      friends = result;
    } else {
      friends = dataFromDb;
    }
    personal = await VKService.getPersonal();
    notifyListeners();
  }
}
