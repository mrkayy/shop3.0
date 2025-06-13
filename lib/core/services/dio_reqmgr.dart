import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shop3/core/app_config.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/di_manager.dart';
// ...existing code...

/// Singleton to manage the last known Dio CancelToken
class DioRequestManager {
  DioRequestManager(this._dio) {
    _dio = this._dio ?? Dio();
  }
  Dio? _dio;
  static CancelToken? lastCancelToken;

  final _defaultHeaders = {'Content-Type': 'application/json'};

  /// dio initialization function
  void initBaseOptions() {
    String baseUrl = getIt<AppConfig>().apiUrl;
    final options = BaseOptions(
      baseUrl: baseUrl,
      headers: _defaultHeaders,
      receiveDataWhenStatusError: true,
      followRedirects: false,
    );

    // dio request
    _dio!.options = options;
    // _dio!.interceptors.add();
  }

  static void setCancelToken(CancelToken token) {
    lastCancelToken = token;
  }

  static void cancelLastRequest() {
    lastCancelToken?.cancel('Cancelled by navigation exit.');
    lastCancelToken = null;
  }

  /// Handles DioExceptions and returns a standardized [Response] containing an [ErrorParser].
  ///
  /// This method inspects the [DioException] [exp], logs relevant debug information,
  /// and generates a [Response] with an [ErrorParser] based on the exception type and status code.
  ///
  /// - For HTTP status codes 400, 401, 403, and 500, it attempts to parse the error response data
  ///   into an [ErrorParser]. If the data is not a map, it creates a default error message.
  /// - For other exception types (e.g., connection errors, timeouts, cancellations, unknown errors),
  ///   it returns a [Response] with an appropriate error message and code.
  ///
  /// Returns:
  ///   A [Response<ErrorParser?>] object representing the standardized error response.

  Response<ErrorParser?> errorHandler(DioException exp) {
    debugPrint('DioException caught:');
    debugPrint('  type: ${exp.type}');
    debugPrint('  uri: ${exp.requestOptions.uri}');
    debugPrint('  statusCode: ${exp.response?.statusCode}');
    debugPrint('  data: ${exp.response?.data}');

    final statusCode = exp.response?.statusCode ?? 400;

    // Only handle 400, 401, 403, 500
    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 500) {
      return Response<ErrorParser?>(
        requestOptions: exp.requestOptions,
        headers: exp.response?.headers ?? Headers(),
        data: ErrorParser.fromJson(
          exp.response?.data is Map<String, dynamic>
              ? exp.response?.data
              : {
                'statusCode': statusCode,
                'message': exp.response?.data?.toString() ?? 'Unknown error',
              },
        ),
        statusCode: statusCode,
      );
    }

    return switch (exp.type) {
      // Match Dio-specific exception types
      DioExceptionType.connectionError => Response<ErrorParser?>(
        requestOptions: exp.requestOptions,
        headers: exp.response?.headers ?? Headers(),
        data: ErrorParser(
          code: statusCode.toString(),
          message:
              exp.message ??
              'Unable to connect to server, please check your internet',
        ),
        statusCode: statusCode,
      ),
      DioExceptionType.connectionTimeout => Response<ErrorParser?>(
        requestOptions: exp.requestOptions,
        headers: exp.response?.headers ?? Headers(),
        // todo: Refactor to use [Pattern Matchinig] to check for correct error received and react to it
        data: ErrorParser(code: '400', message: 'Network connection timeout'),
        statusCode: 000,
      ),

      // Match HTTP status codes with response present
      DioExceptionType.cancel => Response<ErrorParser?>(
        requestOptions: exp.requestOptions,
        headers: exp.response?.headers ?? Headers(),
        data: ErrorParser(
          code: '000',
          message: exp.message ?? 'An unknown error occurred',
        ),
        statusCode: statusCode,
      ),

      DioExceptionType.unknown => Response<ErrorParser?>(
        requestOptions: exp.requestOptions,
        headers: exp.response?.headers ?? Headers(),
        data: ErrorParser(
          code: statusCode.toString(),
          message: exp.message ?? 'An unknown error occurred',
        ),
        statusCode: statusCode,
      ),
      // Fallback for other errors
      _ => Response<ErrorParser?>(
        requestOptions: exp.requestOptions,
        headers: exp.response?.headers ?? Headers(),
        data: ErrorParser(
          code: '000',
          message: exp.message ?? 'An unknown error occurred',
        ),
        statusCode: statusCode,
      ),
    };
  }

  /// GET: method
  Function(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  })
  get getRequest => _dio!.get;

  /// POST: method
  Function(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  })
  get postRequest => _dio!.post;

  /// PUT: method
  Function(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  })
  get putRequest => _dio!.put;
}
