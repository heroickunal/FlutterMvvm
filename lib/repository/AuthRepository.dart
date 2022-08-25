import 'package:mvvm/data/network/BaseApiService.dart';
import 'package:mvvm/data/network/NetworkApiService.dart';

import '../res/AppUrl.dart';

class AuthRepository {
  BaseApiService apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = apiService.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = apiService.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
