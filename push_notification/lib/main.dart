import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return MyAppState()._showNotification(message);
}

class MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification'),
      ),
      body: Center(
        child: Text('button'),
      ),
    );
  }

  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel desc',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
    new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'new message arived',
      'i want ${message['data']['title']} for ${message['data']['price']}',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  getTokenz() async {
    String? token = await _firebaseMessaging.getToken();
    print(token);
  }

  Future selectNotification(String? payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('new message arived'),
              content: Text(
                  'i want ${message.data["title"]}'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    });

    getTokenz();
  }
}