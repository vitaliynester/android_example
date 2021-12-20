import 'package:android_tutorial/providers/providers.dart';
import 'package:android_tutorial/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  Future loadPage;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<AppProvider>(context, listen: false);
    loadPage = provider.friends.isEmpty
        ? provider.getFriends()
        : Future.value(provider.friends);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список друзей", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder(
              future: loadPage,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? ListView.builder(
                        itemCount: provider.friends.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: FriendCardWidget(
                              friend: provider.friends[index],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
