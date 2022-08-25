import 'package:flutter/cupertino.dart';
import 'package:mvvm/repository/AuthRepository.dart';

class AuthViewModel extends ChangeNotifier {
  final authRepo = AuthRepository();

  Future<dynamic> login(dynamic data) async {
    authRepo
        .loginApi(data)
        .then((value) => {print("Success -> ${value.toString()}")})
        .onError(
            (error, stackTrace) => {print("Error -> ${error.toString()}")});
  }
}
