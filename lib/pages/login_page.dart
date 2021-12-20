import 'package:android_tutorial/models/models.dart';
import 'package:android_tutorial/pages/pages.dart';
import 'package:android_tutorial/providers/providers.dart';
import 'package:android_tutorial/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      extendBodyBehindAppBar: true,
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: WebView(
              initialUrl: VKService.authUrl,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) async {
                print(request);
                var uri = Uri.parse(request.url);
                if (uri.fragment.contains('access_token')) {
                  var data = uri.fragment.split('&');
                  var accessToken = data
                      .where((element) => element.contains('access_token'))
                      .first
                      .replaceAll('access_token=', '');
                  var userId = data
                      .where((element) => element.contains('user_id'))
                      .first
                      .replaceAll('user_id=', '');
                  print(accessToken);
                  var user = UserModel(
                    token: accessToken,
                    id: int.parse(userId),
                  );
                  await UserService.saveUser(user);
                  provider.updateUser(user);
                  NavigatorService.pushUntil(context, HomePage());
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          );
        },
      ),
    );
  }
}
