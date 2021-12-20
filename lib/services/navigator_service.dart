import 'package:flutter/material.dart';

class NavigatorService {
  static dynamic push(BuildContext context, Widget page) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  static dynamic pushUntil(BuildContext context, Widget page) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
