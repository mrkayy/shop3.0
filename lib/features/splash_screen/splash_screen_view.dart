import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shop3/core/repositories/auth_repo.dart';
import 'package:shop3/core/repositories/products_repo.dart';
import 'package:shop3/core/services/native_services/ios_platform_channel.dart';
import 'package:shop3/core/services/repository_services/cache_service.dart';
import 'package:shop3/core/services/repository_services/products_service.dart';
import 'package:shop3/core/services/repository_services/user_auth_service.dart';
import 'package:shop3/di_manager.dart';
import 'package:shop3/routes/app_router.dart';
import 'package:shop3/theme.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  String deviceName = '';
  String deviceVersion = '';

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // final products = await ProductServices(getIt<ProductsInterface>())
      //     .fetchAllProductsByCategory(1);
      // debugPrint('Fetched products: $products \n');
      // final category = await ProductServices(getIt<ProductsInterface>()).fetchCategories();
      // debugPrint('Fetched products: $category\n');

      // final signin = await UserAuthServices(getIt<AuthenticationInterface>()).signinUser({
      //   'email': 'josepholukayode05@gmil.com',
      //   'password': 'password',
      // });
      // debugPrint('signin user: $signin\n');
      // final email = await UserAuthServices(
      //   getIt<AuthenticationInterface>(),
      // ).emailCanSignup({'email': 'josepholukayode05@gmil.com'});
      // debugPrint('email exist: $email\n');
      // final signup = await UserAuthServices(getIt<AuthenticationInterface>()).signupNewUser({
      //   'email': '',
      //   'password': 'password',
      // });
      // debugPrint('Signiin up user: $signup\n');

      final nativePlatform = await NativeMethodChannelPlatform();
      final deviceInfo = await nativePlatform.getNavtivePlatformDeviceInfo();
      setState(() {
        deviceName = deviceInfo['name'];
        deviceVersion = deviceInfo['systemVersion'];
      });

      final cache = await CacheService.getInstance();
     bool isLoggedIn = await cache.getBool('isLoggedIn') ?? false;
     bool hasAuthToken = (await cache.getString('authToken') ?? '').isNotEmpty;

      if (isLoggedIn && hasAuthToken ) {
        Future.delayed(const Duration(seconds: 2), () {
          context.pushReplacement(productsView);
        });
      }else {
        Future.delayed(const Duration(seconds: 2), () {
          context.pushReplacement(signinView);
        });

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shop3.0',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: AppTheme.secondaryColor,
              ),
            ),
            4.verticalSpace,
            Text(
              '$deviceName - $deviceVersion',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 12,
                color: AppTheme.textColor100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
