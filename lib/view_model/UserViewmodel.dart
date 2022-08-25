import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/model/UserModel.dart';
import 'package:mvvm/repository/AuthRepository.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Constant.dart';
import '../utils/utils.dart';

class UserViewModel extends ChangeNotifier {
  Future<bool> saveUserToken(UserModel userModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString(Constant.TOKEN, userModel.token.toString());

    notifyListeners();
    return true;
  }

  Future<UserModel> getUserToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    notifyListeners();
    return UserModel(token: sp.getString(Constant.TOKEN));
  }

  Future<bool> removeUserToken()async{

    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.clear();
  }
}
