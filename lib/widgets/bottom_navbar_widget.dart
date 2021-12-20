import 'package:android_tutorial/providers/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album),
              label: 'Друзья',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Персональная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gamepad),
              label: 'Змейка',
            ),
          ],
          currentIndex: provider.index,
          selectedItemColor: Colors.blue,
          onTap: provider.updateIndex,
        );
      },
    );
  }
}
