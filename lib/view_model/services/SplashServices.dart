import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:mvvm/view_model/UserViewmodel.dart';
import 'package:objectbox/src/native/box.dart';

import '../../data/model/UserModel.dart';
import '../../utils/utils.dart';

class SplashServices extends ChangeNotifier {

  Future<UserModel> getUserData() => UserViewModel().getUserToken();
/*
  void checkAuth(BuildContext context) async {
    getUserData().then((value) async {

      Utils.log(value.token.toString());
      if (value.token == null || value.token == "null" || value.token == "") {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      Utils.log(error.toString());
    });
  }*/


  Future<bool> checkAuth(BuildContext context) async {

    var isLoggedIn = false;

    getUserData().then((value) async {

      Utils.log(value.token.toString());
      if (value.token == null || value.token == "null" || value.token == "") {

        Utils.log("isLoggedIn == null--> false string");
        isLoggedIn = false;
      } else {

        Utils.log("isLoggedIn--> true string");
        isLoggedIn = true;
      }
    }).onError((error, stackTrace) {
      Utils.log(error.toString());

      Utils.log("isLoggedIn error --> false string");
      isLoggedIn = false;
    });

    await Future.delayed(const Duration(seconds: 3));
    notifyListeners();
    return isLoggedIn;
  }
}
