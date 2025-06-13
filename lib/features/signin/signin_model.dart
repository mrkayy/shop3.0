class UserSignInModel {
  final String accessToken;
  final String refreshToken;

  UserSignInModel({required this.accessToken, required this.refreshToken});

  factory UserSignInModel.fromJson(Map<String, dynamic> json) {
    return UserSignInModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}
