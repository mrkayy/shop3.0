class AppConfig {
  final String baseUrl;
  final String version;

  AppConfig({required this.baseUrl, required this.version});

  String get apiUrl => '$baseUrl$version';
}
