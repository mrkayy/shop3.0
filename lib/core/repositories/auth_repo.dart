import 'package:dio/dio.dart';
import 'package:shop3/core/services/dio_reqmgr.dart';
import 'package:shop3/core/services/endpoints.dart';

abstract interface class AuthenticationInterface {
  Future<Response> signupNewUser(Map<String, dynamic> data);
  Future<Response> signinUser(Map<String, dynamic> data);
  Future<Response> isUserEmailAvaliable(Map<String, dynamic> data);
}

final class AuthenticationRepo implements AuthenticationInterface {
  AuthenticationRepo(this._apiService);
  DioRequestManager _apiService;

  @override
  Future<Response> isUserEmailAvaliable(Map<String, dynamic> data) async {
     try {
       Response response = await _apiService.postRequest(Endpoints.isEmailAvaliable, data: data);
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }

  @override
  Future<Response> signinUser(Map<String, dynamic> data) async {
    try {
       Response response = await _apiService.postRequest(Endpoints.signinUser, data: data);
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }

  @override
  Future<Response> signupNewUser(Map<String, dynamic> data) async {
    try {
       Response response = await _apiService.postRequest(Endpoints.signupUser, data: data);
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }
}