import 'package:dio/dio.dart';
import 'package:shop3/core/services/dio_reqmgr.dart';
import 'package:shop3/core/services/endpoints.dart';

abstract interface class UserProfileInterface {
  /// PUT: request
  /// todo: persist user profile_image as Uint8 to `IOS local cache`
  Future<Response> updateUserProfile(Map<String, dynamic> data);
  Future<Response> getUserProfile();
}

final class UserProfileRepo implements UserProfileInterface {
  UserProfileRepo(this._apiService);
  DioRequestManager _apiService;
  @override
  Future<Response> getUserProfile() async {
    try {
      Response response = await _apiService.getRequest(Endpoints.userProfile);
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }

  @override
  Future<Response> updateUserProfile(Map<String, dynamic> data) async {
    try {
      Response response = await _apiService.putRequest(
        Endpoints.updateUserProfile(data['id']),
        data: data,
      );
      return response;
    } on DioException catch (exp) {
      return _apiService.errorHandler(exp);
    }
  }
}
