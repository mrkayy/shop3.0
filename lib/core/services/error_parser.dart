
/// Default implementation of [Exception] which carries a message.
/// To be used to handle provider exceptions
class ProviderException implements Exception {
  ProviderException([this.message]);
  final dynamic message;

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return 'An error occured';
    return '$message';
  }
}

final class ErrorParser {
  ErrorParser({this.code, this.message});

  factory ErrorParser.fromJson(Map<String, dynamic> json) {
    return ErrorParser(
      code: json['statusCode']?.toString() ?? json['code']?.toString(),
      message: json['message']?.toString(),
    );
  }

  final String? code;
  final String? message;
}
