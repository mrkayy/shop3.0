import 'package:equatable/equatable.dart';
import 'package:shop3/core/services/error_parser.dart';

class SigninViewModel extends Equatable {
  SigninViewModel({
    this.email,
    this.password,
    this.error,
    this.onSignSuccess,
    this.loading,
  });
  final String? email;
  final ErrorParser? error;
  final String? password;
  final bool? onSignSuccess;
  final bool? loading;
  SigninViewModel copyWith({
    String? email,
    ErrorParser? error,
    String? password,
    bool? onSignSuccess,
    bool? loading,
  }) {
    return SigninViewModel(
      error: error ?? this.error,
      email: email ?? this.email,
      password: password ?? this.password,
      onSignSuccess: onSignSuccess ?? this.onSignSuccess,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [email, password, error, onSignSuccess, loading];
}
