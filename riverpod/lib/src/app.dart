import 'package:flutter/material.dart';
import 'package:marvel/src/screens/splash_screen.dart';
import 'package:marvel/src/utils/routers.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Marvel',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routers.generateRoute,
      initialRoute: '/',
    );
  }
}