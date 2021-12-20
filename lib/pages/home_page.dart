import 'package:android_tutorial/pages/pages.dart';
import 'package:android_tutorial/providers/providers.dart';
import 'package:android_tutorial/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final pages = [
    FriendsPage(),
    PersonalPage(),
    SensorPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: pages[provider.index],
          bottomNavigationBar: BottomNavbarWidget(),
        );
      },
    );
  }
}
