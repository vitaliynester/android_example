import 'package:android_tutorial/pages/pages.dart';
import 'package:android_tutorial/services/services.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future loadPage;

  @override
  void initState() {
    super.initState();
    loadPage = UserService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadPage,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.data == null
                  ? LoginPage()
                  : HomePage()
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
