import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/data/network/BaseApiService.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';

import '../objectbox.g.dart';
import '../res/AppUrl.dart';
import '../utils/utils.dart';

class AuthRepository {
  BaseApiService apiService;
  Box<UserModelDb> userModelBox;

  AuthRepository({required this.apiService, required this.userModelBox});

  Future<String> getToken() async {
    try {
      var token = "";
      if (userModelBox.getAll().isNotEmpty) {
        token = userModelBox.getAll().first.token;
        Utils.log(
            "Token from database is -> ${userModelBox.getAll().first.token}");
      }
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> saveToken(String token) async {
    try {
      var success = userModelBox.put(UserModelDb(token: token, id: 1));
      return success;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginApi(dynamic data) async {
    try {
      if (userModelBox.getAll().isNotEmpty) {
        Utils.log(
            "Token from database is -> ${userModelBox.getAll().first.token}");
      }
      dynamic response = apiService.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = apiService.getPostApiResponse(AppUrl.signUpUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
