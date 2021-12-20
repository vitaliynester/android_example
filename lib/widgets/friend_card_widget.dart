import 'package:android_tutorial/models/friend_model.dart';
import 'package:android_tutorial/providers/app_provider.dart';
import 'package:android_tutorial/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendCardWidget extends StatelessWidget {
  final FriendModel friend;

  FriendCardWidget({@required this.friend});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var personal = await VKService.getPersonal(id: friend.id);
        var provider = Provider.of<AppProvider>(context, listen: false);
        provider.updatePersonal(personal);
        provider.updateIndex(1);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${friend.lastName} ${friend.firstName}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Номер телефона: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (friend.mobilePhone.isNotEmpty) {
                        await launch('tel://${friend.mobilePhone}');
                      }
                    },
                    child: Text(
                      friend.mobilePhone.isEmpty
                          ? "отсутствует"
                          : friend.mobilePhone,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
