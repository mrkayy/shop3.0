import 'package:shop3/core/services/error_parser.dart';

typedef EitherErrorOrResponse<T> = Future<({ErrorParser? err, T? res})>;
typedef RequestPayload = Map<String, dynamic>;
