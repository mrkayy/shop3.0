import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shop3/core/repositories/auth_repo.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/services/repository_services/user_auth_service.dart';
import 'package:shop3/di_manager.dart';
import 'package:shop3/features/signup/signup_viewmodel.dart';

part 'signup_notifier.g.dart';

@riverpod
class SignupViewModelNotifier extends _$SignupViewModelNotifier {
  @override
  SignupViewModel build() {
    return SignupViewModel(onSignupSuccess: false, loading: false);
  }

  set setName(String name) {
    state = state.copyWith(name: name, error: null);
  }

  set setEmail(String email) {
    state = state.copyWith(email: email, error: null);
  }

  set setPassword(String password) {
    state = state.copyWith(password: password, error: null);
  }

  void loading() {
    state = state.copyWith(loading: !state.loading!, error: null);
  }

  Future<void> signup() async {
    loading();
    try {
      final signin = await UserAuthServices(
        getIt<AuthenticationInterface>(),
      ).signinUser({'name': state.name, 'avatar': '','email': state.email!, 'password': state.password!});

      loading();

      if (signin.err == null) {
        state = state.copyWith(error: null, onSignupSuccess: true);
      } else {
        state = state.copyWith(error: signin.err, onSignupSuccess: false);
      }
    } catch (e) {
      state = state.copyWith(
        error: ErrorParser(message: '$e'),
        onSignupSuccess: false,
      );
    }
  }
}
