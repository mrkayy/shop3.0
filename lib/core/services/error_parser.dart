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
  ErrorParser({this.code, this.error, this.message});

  /// Factory to parse from backend JSON
  factory ErrorParser.fromJson(Map<String, dynamic> json) {
    // message can be a List or String
    final dynamic msg = json['message'];
    List<String> parsedMessages;
    if (msg is List) {
      parsedMessages = msg.map((e) => e.toString()).toList();
    } else if (msg is String) {
      parsedMessages = [msg];
    } else {
      parsedMessages = [];
    }

    return ErrorParser(
      code: json['statusCode']?.toString() ?? json['code']?.toString(),
      error: json['error']?.toString(),
      message: parsedMessages,
    );
  }

  final String? code; // statusCode as string
  final String? error; // error field (e.g., "Bad Request")
  final List<String>? message; // always a list of message
}
