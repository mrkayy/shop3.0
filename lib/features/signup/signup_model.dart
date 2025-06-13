class UserSignupModel {
  final String email;
  final String password;
  final String name;
  final String avatar;
  final String role;
  final int id;

  UserSignupModel({
    required this.email,
    required this.password,
    required this.name,
    required this.avatar,
    required this.role,
    required this.id,
  });

  factory UserSignupModel.fromJson(Map<String, dynamic> json) {
    return UserSignupModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      role: json['role'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'avatar': avatar,
      'role': role,
      'id': id,
    };
  }
}
