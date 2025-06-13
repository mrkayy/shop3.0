import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/utils/constants.dart';
import 'package:shop3/features/signup/notifiers/signup_notifier.dart';
import 'package:shop3/routes/app_router.dart';

class SignupView extends ConsumerWidget {
  SignupView({super.key});

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    ref.listen<ErrorParser?>(
      signupViewModelNotifierProvider.select((state) => state.error),
      (prev, next) {
        if (next?.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${next?.message} Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
    //
    ref.listen<bool?>(
      signupViewModelNotifierProvider.select((state) => state.onSignupSuccess),
      (prev, next) {
        if (next ?? false) {
          context.pushReplacement(signinView);
        }
      },
    );
    final stateRef = ref.watch(signupViewModelNotifierProvider);
    final readRef = ref.read(signupViewModelNotifierProvider.notifier);
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: kScreenPadding,
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                20.verticalSpace,
                Text(
                  'Create your account',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: const Color.fromARGB(255, 31, 23, 23),
                    fontSize: 22,
                    height:
                        (22 / 28), // fontsize / font_weight gives font_height
                  ),
                ),
                12.verticalSpace,
                Text(
                  'Please enter your credentials to continue.',
                  style: theme.textTheme.bodyMedium!.copyWith(),
                ),
                24.verticalSpace,
                TextFormField(
                  controller: _name,
                  onSaved: (v) {
                    readRef.setName = v!;
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'invalid name.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                24.verticalSpace,
                TextFormField(
                  controller: _email,
                  onSaved: (v) {
                    readRef.setEmail = v!;
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'invalid email address.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                24.verticalSpace,
                TextFormField(
                  controller: _password,
                  onSaved: (v) {
                    readRef.setPassword = v!;
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Invaid password input';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                24.verticalSpace,
                TextFormField(
                  controller: _confirm,
                  // onSaved: (v) {},
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Invaid input';
                    }
                    if (v == _password.text) return null;

                    return 'Password miss match';
                  },
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                ),
                24.verticalSpace,
                ElevatedButton(
                  onPressed:
                      !stateRef.loading!
                          ? null
                          : () async {
                            final form = _form.currentState!;
                            if (form.validate()) {
                              form.save();
                              readRef.signup();
                            }
                          },
                  child: Text('Sign Up'),
                ),
                40.verticalSpace,
                TextButton(
                  onPressed: () {
                    context.push(signinView);
                  },
                  child: Text('Already have an account? Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
