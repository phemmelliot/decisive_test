import 'package:decisive_app/pages/home/home.dart';
import 'package:decisive_app/pages/login/signin.dart';
import 'package:decisive_app/pages/signup/signup.dart';
import 'package:decisive_app/pages/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/signup':
        return MaterialPageRoute(builder: (context) => Signup());
        break;
      case '/home':
        return MaterialPageRoute(builder: (context) => Home());
      default:
        return null;
    }
  }
}
