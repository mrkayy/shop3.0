import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shop3/core/repositories/auth_repo.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/services/repository_services/user_auth_service.dart';
import 'package:shop3/di_manager.dart';
import 'package:shop3/features/signin/signin_viewmodel.dart';

part 'signin_notifier.g.dart';

@riverpod
class SigninNotifier extends _$SigninNotifier {
  @override
  SigninViewModel build() {
    return SigninViewModel(onSignSuccess: false, loading: false);
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

  Future<void> signin() async {
    loading();
    try {
      final signin = await UserAuthServices(
        getIt<AuthenticationInterface>(),
      ).signinUser({'email': state.email!, 'password': state.password!});

      loading();

      if (signin.err == null) {
        state = state.copyWith(error: null, onSignSuccess: true);
      } else {
        state = state.copyWith(error: signin.err, onSignSuccess: false);
      }
    } catch (e) {
      state = state.copyWith(
        error: ErrorParser(message: ['$e']),
        onSignSuccess: false,
      );
    }
  }
}
