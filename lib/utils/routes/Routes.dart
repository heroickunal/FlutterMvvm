import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:mvvm/view/HomeScreen.dart';
import 'package:mvvm/view/LoginScreen.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
    }
  }
}
