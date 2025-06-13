library app_router;

import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shop3/core/services/repository_services/cache_service.dart';
import 'package:shop3/features/profile/profile_view.dart';
import 'package:shop3/features/shop/views/product_detail.dart';
import 'package:shop3/features/shop/views/products_view.dart';
import 'package:shop3/features/signin/signin_view.dart';
import 'package:shop3/features/signup/signup_view.dart';
import 'package:shop3/features/splash_screen/splash_screen_view.dart';

part 'routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shop3.app;',
);

GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;

//

class ApplicationRoutes {
  GoRouter get getRoutesConfig => _router;
  static final ValueNotifier<bool> _refreshNotifier = ValueNotifier<bool>(
    false,
  );
  //
  static final GoRouter _router = GoRouter(
    refreshListenable: _refreshNotifier,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    initialLocation: rootView,
    // redirect: _loginRedirectFunction,
    routes: [
      GoRoute(path: rootView, builder: (context, state) => SplashScreenView()),
      GoRoute(
        path: signinView,
        builder: (context, state) => SigninView(),
        // onExit: (context, state) async {
        //   // Cancel the last known Dio request
        //   DioRequestManager.cancelLastRequest();
        //   final result = await showDialog<bool>(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: const Text('Do you want to exit this page?'),
        //         actions: <Widget>[
        //           TextButton(
        //             style: TextButton.styleFrom(
        //               textStyle: Theme.of(context).textTheme.labelLarge,
        //             ),
        //             child: const Text('Go Back'),
        //             onPressed: () {
        //               Navigator.of(context).pop(false);
        //             },
        //           ),
        //           TextButton(
        //             style: TextButton.styleFrom(
        //               textStyle: Theme.of(context).textTheme.labelLarge,
        //             ),
        //             child: const Text('Confirm'),
        //             onPressed: () {
        //               Navigator.of(context).pop(true);
        //             },
        //           ),
        //         ],
        //       );
        //     },
        //   );
        //   return result ?? false;
        // },
      ),
      GoRoute(
        path: signupView,
        builder: (context, state) => SignupView(),

        /// This function is used to redirect the user based on whether they have registered or not.
        /// It checks if the 'hasRegister' flag is stored in the cache.
        /// If the user has registered, they are redirected to the sign-in view.
        /// Otherwise, no redirection occurs.
        redirect: (context, state) async {
          final cache = await CacheService.getInstance();
          bool hasRegister = await cache.getBool('hasRegister') ?? false;
          if (hasRegister) {
            return signinView;
          }
          return null;
        },
      ),
      GoRoute(path: profileView, builder: (context, state) => ProfileView()),
      GoRoute(
        path: productsView,
        builder: (context, state) => ProductsHomeView(),
      ),
      GoRoute(
        path: productsDetailsView,
        builder: (context, state) {
          final pid = state.uri.queryParameters['id'];
          return ProductDetailView(pid: pid);
        },
      ),
    ],
  );
}
