
// ignore: prefer_single_quotes
import "package:plugin_platform_interface/plugin_platform_interface.dart";
import 'package:shop3/core/services/native_services/ios_platform_channel.dart';

abstract class NativeMethodChannelPlatformInterface extends PlatformInterface {

  /// Constructs a ActivityCapturePlatform.
 NativeMethodChannelPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static NativeMethodChannelPlatformInterface _instance = NativeMethodChannelPlatform();

  /// The default instance of  NativeMethodChannelPlatformInterface] to use.
  ///
  /// Defaults to [SingleEyeMethodChannel].
  static NativeMethodChannelPlatformInterface get instance => _instance;

  /// Platform-specific implementations should set this wth their own
  /// platform-specific class that extends  NativeMethodChannelPlatformInterface] when
  /// they register themselves.
  static set instance (NativeMethodChannelPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }


  Future<Map<String, dynamic>> getNavtivePlatformDeviceInfo() {
    throw UnimplementedError('getNavtivePlatformDeviceInfo() has not been implemented');
  }

}
