import 'package:flutter/material.dart';
import 'package:marvel/src/screens/detail_screen.dart';
import 'package:marvel/src/screens/home_screen.dart';
import 'package:marvel/src/screens/splash_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/detail':
        return MaterialPageRoute(builder: (_) => DetailScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}