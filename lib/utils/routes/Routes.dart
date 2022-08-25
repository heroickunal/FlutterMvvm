import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:mvvm/view/HomeScreen.dart';
import 'package:mvvm/view/LoginScreen.dart';
import 'package:mvvm/view/SignUpScreen.dart';
import 'package:mvvm/view/SplashScreen.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
    }
  }
}
