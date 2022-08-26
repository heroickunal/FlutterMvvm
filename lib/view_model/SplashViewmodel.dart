import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/model/UserModel.dart';
import 'package:mvvm/repository/AuthRepository.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Constant.dart';
import '../utils/utils.dart';
import '../view/LoginScreen.dart';
import 'UserViewmodel.dart';

class SplashViewModel extends ChangeNotifier {

  bool isLoggedIn = false;

  bool get isUserLoggedIn => isLoggedIn;

  void setLogin(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }


  Future<UserModel> getUserData() => UserViewModel().getUserToken();

  Future<bool> checkAuth(BuildContext context) async {
    getUserData().then((value) async {

      Utils.log(value.token.toString());
      if (value.token == null || value.token == "null" || value.token == "") {

        Utils.log("isLoggedIn--> false string");
        await Future.delayed(Duration(seconds: 3));

        notifyListeners();
        return false;
      } else {

        Utils.log("isLoggedIn--> true string");
        await Future.delayed(Duration(seconds: 3));

        notifyListeners();
        return true;
      }
    }).onError((error, stackTrace) {
      Utils.log(error.toString());

      notifyListeners();
      return false;
    });

    notifyListeners();
    return false;
  }
}
