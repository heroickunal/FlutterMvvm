import 'package:flutter/cupertino.dart';
import 'package:mvvm/repository/AuthRepository.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';

import '../utils/utils.dart';

class AuthViewModel extends ChangeNotifier {
  final authRepo = AuthRepository();

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
      setLoading(false);
      Utils.log("Success -> ${value.toString()}");
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      Utils.log("Error -> ${error.toString()}");
    });
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
}
