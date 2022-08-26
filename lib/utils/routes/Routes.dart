import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:mvvm/view/HomeScreen.dart';
import 'package:mvvm/view/LoginScreen.dart';
import 'package:mvvm/view/SignUpScreen.dart';
import 'package:mvvm/view/SplashScreen.dart';

import '../../data/local_db/UserDbModel.dart';
import '../../objectbox.g.dart';

class Routes {
  static MaterialPageRoute generateRoute(
      RouteSettings settings, Box<UserModelDb> userModelBox) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                HomeScreen(userModelBox: userModelBox));

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginScreen(userModelBox: userModelBox));

      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());
    }
  }
}
