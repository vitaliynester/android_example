import 'package:android_intent/android_intent.dart';
import 'package:android_tutorial/providers/app_provider.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  Future loadPage;

  @override
  void initState() {
    super.initState();
    loadPage = Provider.of<AppProvider>(context, listen: false).getForPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          "Персональная страница",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_sharp, color: Colors.black),
            onPressed: () async {
              setState(() {
                var provider = Provider.of<AppProvider>(context, listen: false);
                provider.updatePersonal(null);
                loadPage = provider.getForPage();
              });
            },
          )
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: loadPage,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? snapshot.data == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(
                              "Невозможно получить данные о конкретном пользователе!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  child: Image.network(
                                    provider.personal.imgUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${provider.personal.lastName} ${provider.personal.firstName}",
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Номер телефона: ",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (provider
                                            .personal.phone.isNotEmpty) {
                                          await launch(
                                              'tel://${provider.personal.phone}');
                                        }
                                      },
                                      child: Text(
                                        provider.personal.phone.isEmpty
                                            ? "отсутствует"
                                            : provider.personal.phone,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextButton(
                                  onPressed: () async {
                                    bool isInstalled =
                                        await DeviceApps.isAppInstalled(
                                      'com.vkontakte.android',
                                    );
                                    if (isInstalled != false) {
                                      AndroidIntent intent = AndroidIntent(
                                        action: 'action_view',
                                        data:
                                            'https://vk.com/id${provider.personal.id}',
                                      );
                                      await intent.launch();
                                    } else {
                                      String url =
                                          'https://vk.com/id${provider.personal.id}';
                                      if (await canLaunch(url))
                                        await launch(url);
                                    }
                                  },
                                  child: Text("Открыть страницу ВК"),
                                ),
                              ],
                            ),
                          ),
                        )
                  : Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
