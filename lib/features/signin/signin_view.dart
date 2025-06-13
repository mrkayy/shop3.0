import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop3/core/services/error_parser.dart';
import 'package:shop3/core/utils/constants.dart';
import 'package:shop3/features/signin/notifiers/signin_notifier.dart';
import 'package:shop3/routes/app_router.dart';

class SigninView extends ConsumerWidget {
  SigninView({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchState = ref.watch(signinNotifierProvider);
    final readState = ref.read(signinNotifierProvider.notifier);

    //
    ref.listen<ErrorParser?>(
      signinNotifierProvider.select((state) => state.error),
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
      signinNotifierProvider.select((state) => state.onSignSuccess),
      (prev, next) {
        if (next ?? false) {
          context.pushReplacement(productsView);
        }
      },
    );

    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(),;
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
                  'Welcome Back',
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
                  controller: _email,
                  onSaved: (v) {
                    readState.setEmail = v!;
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      'invalid email address.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                24.verticalSpace,
                TextFormField(
                  controller: _password,
                  onSaved: (v) {
                    readState.setPassword = v!;
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      'invalid password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                8.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot password?'),
                  ),
                ),
                24.verticalSpace,
                ElevatedButton(
                  onPressed:
                      !watchState.loading!
                          ? () async {
                            final form = _form.currentState!;
                            if (form.validate()) {
                              form.save();
                              readState.signin();
                            }
                          }
                          : null,
                  child: Text('Sign In'),
                ),
                40.verticalSpace,
                TextButton(
                  onPressed: () {
                    context.push(signupView);
                  },
                  child: Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
