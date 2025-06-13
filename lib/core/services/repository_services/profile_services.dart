import 'package:dio/dio.dart';
import 'package:shop3/core/repositories/profile_repo.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/utils/typedef.dart';
import 'package:shop3/features/profile/profile_model.dart';

class UserProfileServices {
  UserProfileServices(this._api);

  final UserProfileInterface _api;

  EitherErrorOrResponse<UserProfileModel?> updateUserProfile(
    RequestPayload data,
  ) async {
    Response res = await _api.updateUserProfile(data);
    try {
      if (res.statusCode! >= 200) {
        var jsonModel = UserProfileModel.fromJson(res.data);
        return (err: null, res: jsonModel);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');

      return (err: error, res: null);
    }

    var error = res.data as ErrorParser;
    return (err: error, res: null);
  }

  EitherErrorOrResponse<UserProfileModel?> getUserProfile(
    RequestPayload data,
  ) async {
    Response res = await _api.getUserProfile();
    try {
      if (res.statusCode! >= 200) {
        var jsonModel = UserProfileModel.fromJson(res.data);
        return (err: null, res: jsonModel);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');

      return (err: error, res: null);
    }

    var error = res.data as ErrorParser;
    return (err: error, res: null);
  }
}
