import 'package:equatable/equatable.dart';
import 'package:shop3/core/services/error_parser.dart';

class SignupViewModel extends Equatable {
  SignupViewModel({
    this.name,
    this.email,
    this.password,
    this.error,
    this.loading,
    this.onSignupSuccess,
  });
  final String? name;
  final String? email;
  final String? password;
  final ErrorParser? error;
  final bool? onSignupSuccess;
  final bool? loading;
  SignupViewModel copyWith({
    String? email,
    String? name,
    ErrorParser? error,
    String? password,
    bool? onSignupSuccess,
    bool? loading,
  }) {
    return SignupViewModel(
      error: error ?? this.error,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      onSignupSuccess: onSignupSuccess ?? this.onSignupSuccess,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [email, name, password, error, onSignupSuccess, loading];
}
