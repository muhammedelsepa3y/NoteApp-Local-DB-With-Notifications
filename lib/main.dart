import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:session5/screens/home.dart';

import 'noteModel.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

initLocalNotifications() async {

  const AndroidInitializationSettings initializationSettingsAndroid =   AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);


}
  @override
  Widget build(BuildContext context) {
  initLocalNotifications();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        Provider<FlutterLocalNotificationsPlugin>(
          create: (_) => flutterLocalNotificationsPlugin,
        ),
      ],
      child: Consumer2<NoteProvider, FlutterLocalNotificationsPlugin>(
        builder: (context, noteProvider, notificationsPlugin, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: noteProvider.isDarkMode ? ThemeData.dark(
              useMaterial3: true,
            ) : ThemeData.light(
              useMaterial3: true,
            ),
            home: SearchScreen(notificationsPlugin: notificationsPlugin),
          );
        },
      ),
    );
  }
}
