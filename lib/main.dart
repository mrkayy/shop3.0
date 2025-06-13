import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop3/core/app_config.dart';
import 'package:shop3/core/services/native_services/ios_platform_channel.dart';
import 'package:shop3/di_manager.dart';
import 'package:shop3/routes/app_router.dart';
import 'package:shop3/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializes the application configuration and sets up required services and device orientation.
  ///
  /// - Creates an [AppConfig] instance using environment variables for `baseUrl` and `version`.
  /// - Initializes service locators and sets the device orientation to portrait mode using [Future.wait].
  /// - Once initialization is complete, runs the main application widget [MainApp].
  const String url = String.fromEnvironment('baseUrl');
  const String version = String.fromEnvironment('version');
  late final AppConfig config = AppConfig(baseUrl: url, version: version);

  Future.wait([
    serviceLocatorInitializer(config),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]).then((_) async {
    final nativePlatform = await NativeMethodChannelPlatform();
    final deviceInfo = await nativePlatform.getNavtivePlatformDeviceInfo();

    debugPrint('Device_Info:::: $deviceInfo');
    runApp(ProviderScope(child: MainApp()));
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  /// Builds the widget tree for this widget.
  ///
  /// Retrieves the current [View] from the [BuildContext], then obtains the
  /// physical screen size and device pixel ratio from the window. These values
  /// can be used for responsive layouts or adapting UI to different screen
  /// densities.
  Widget build(BuildContext context) {
    final window = View.of(context);
    final physicalScreenSize = window.physicalSize;
    final pixelRatio = window.devicePixelRatio;

    // Calculate dp (logical size)
    final screenWidthDp = physicalScreenSize.width / pixelRatio;
    final screenHeightDp = physicalScreenSize.height / pixelRatio;
    return ScreenUtilInit(
      designSize: Size(screenWidthDp, screenHeightDp),
      splitScreenMode: false,
      minTextAdapt: true,
      builder:
          /// Creates a [MediaQuery] widget with clamped text scaling, ensuring that the
          /// text scale factor stays within the specified [minScaleFactor] and [maxScaleFactor]
          /// bounds. This helps maintain consistent text sizing across different devices
          /// and user accessibility settings.
          ///
          /// - [minScaleFactor]: The minimum allowed text scale factor (e.g., 0.75).
          /// - [maxScaleFactor]: The maximum allowed text scale factor (e.g., 1.2).
          (_, __) => MediaQuery.withClampedTextScaling(
            minScaleFactor: 0.85,
            maxScaleFactor: 1.2,
            child: MaterialApp.router(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system, // Light, dark, or system preference
              debugShowCheckedModeBanner: kDebugMode,
              routerConfig: ApplicationRoutes().getRoutesConfig,
            ),
          ),
    );
  }
}
