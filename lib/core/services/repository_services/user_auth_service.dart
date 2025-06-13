import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shop3/core/repositories/auth_repo.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/services/repository_services/cache_service.dart';
import 'package:shop3/core/utils/typedef.dart';
import 'package:shop3/features/signin/signin_model.dart';
import 'package:shop3/features/signup/signup_model.dart';

class UserAuthServices {
  UserAuthServices(this._api);

  final AuthenticationInterface _api;

  EitherErrorOrResponse<UserSignupModel?> signupNewUser(
    RequestPayload data,
  ) async {
    Response res = await _api.signupNewUser(data);
    try {
      if (res.statusCode! >= 200) {
        var jsonModel = UserSignupModel.fromJson(res.data);

        final cache = await CacheService.getInstance();
        await cache.setBool('hasRegister', true);
        await cache.setString('profile', json.encode(res.data));
        return (err: null, res: jsonModel);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');

      return (err: error, res: null);
    }

    var error = ErrorParser.fromJson(res.data);
    return (err: error, res: null);
  }

  EitherErrorOrResponse<UserSignInModel?> signinUser(
    RequestPayload data,
  ) async {
    Response res = await _api.signinUser(data);
    try {
      if (res.statusCode! >= 200) {
        var jsonModel = UserSignInModel.fromJson(res.data);

        final cache = await CacheService.getInstance();
        await cache.setBool('isLoggedIn', true);
        await cache.setString('authToken', jsonModel.accessToken);
        return (err: null, res: jsonModel);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');
    print('got here');
      return (err: error, res: null);
    }

    var error = ErrorParser.fromJson(res.data);
    return (err: error, res: null);
  }

  EitherErrorOrResponse<bool?> emailCanSignup(RequestPayload data) async {
    Response res = await _api.isUserEmailAvaliable(data);
    try {
      if (res.statusCode! >= 200) {
        var result = res.data['isAvailable'] as bool;
        return (err: null, res: result);
      }
    } catch (e) {
      var error = ErrorParser(code: '000', message: '$e');

      return (err: error, res: null);
    }

    var error = ErrorParser.fromJson(res.data);
    return (err: error, res: null);
  }
}
