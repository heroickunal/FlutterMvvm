import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/data/network/BaseApiService.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';

import '../objectbox.g.dart';
import '../res/AppUrl.dart';

class AuthRepository {
  BaseApiService apiService;
  Box<UserModelDb> userModelBox;

  AuthRepository({required this.apiService,required this.userModelBox});

  Future<dynamic> loginApi(dynamic data) async {
    try {
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
