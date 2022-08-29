import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/repository/AuthRepository.dart';
import 'package:mvvm/view/HomeScreen.dart';
import 'package:provider/provider.dart';

import '../data/model/UserModel.dart';
import '../objectbox.g.dart';
import '../utils/Constant.dart';
import '../utils/routes/RoutesName.dart';
import '../utils/utils.dart';
import 'UserViewmodel.dart';

class AuthViewModel extends ChangeNotifier {

  final AuthRepository authRepo;

  AuthViewModel({required this.authRepo});

  //Login
  bool _isLoginApiLoading = false;

  setLoading(bool value) {
    _isLoginApiLoading = value;
    notifyListeners();
  }

  bool get isLoginApiLoading => _isLoginApiLoading;

  //Register
  bool _isRegisterApiLoading = false;

  setRegisterApiLoading(bool value) {
    _isRegisterApiLoading = value;
    notifyListeners();
  }

  bool get isRegisterApiLoading => _isRegisterApiLoading;

  Future<dynamic> login(dynamic data, BuildContext context) async {
    setLoading(true);
    authRepo.loginApi(data).then((value) {
      /*saveUserToken(authRepo.userModelBox, value.toString());*/

      authRepo.saveToken(value.toString());

      setLoading(false);
      Utils.log("Success -> ${value.toString()}");
      Navigator.pushNamed(context, RoutesName.home);

      /*Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                HomeScreen()),
      );*/

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference
          .saveUserToken(UserModel(token: value[Constant.TOKEN].toString()));
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      Utils.log("Error -> ${error.toString()}");
    });
  }

  void saveUserToken(Box<UserModelDb> userBox, String token) {
    userBox.put(UserModelDb(token: token, id: 0));

    /*Utils.log("saveUserToken==> ${userBox.get(0)}");*/
    /*Query<UserModelDb> query =
    userBox.query(UserModelDb_.id.equals(0)).build();
    List<UserModelDb> userModelDb = query.find();
    query.close();*/

    List<UserModelDb>? tokens = userBox.getAll().reversed.toList() ?? [];

    Utils.log("Token is --> ${tokens.first.token}");
  }

  Future<dynamic> signUp(dynamic data, BuildContext context) async {
    setRegisterApiLoading(true);
    authRepo.signUpApi(data).then((value) {
      setRegisterApiLoading(false);

      Utils.log("Success -> ${value.toString()}");
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setRegisterApiLoading(false);

      Utils.flushBarErrorMessage(error.toString(), context);
      Utils.log("Error -> ${error.toString()}");
    });
  }

  String _SavedToken = "";

  String get savedToken => _SavedToken;

  setToken(String token) {
    _SavedToken = token;
    notifyListeners();
  }

  void getToken() async {

    authRepo.getToken().then((value) {
      setToken(value);
    });
  }
}
