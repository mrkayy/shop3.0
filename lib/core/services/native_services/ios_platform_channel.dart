import 'dart:io';

import 'package:flutter/services.dart';
import 'package:shop3/core/services/native_services/ios_platform_channel_interface.dart';

class NativeMethodChannelPlatform
    implements NativeMethodChannelPlatformInterface {
  static final _channel = const MethodChannel('com.example.shop3/systemInfo');

  @override
  Future<Map<String, dynamic>> getNavtivePlatformDeviceInfo() async {
    if (Platform.isAndroid) return {};
    try {
      final result = await _channel.invokeMethod<Map>('getDeviceInfo');
      return Map<String, dynamic>.from(result ?? {});
    } on PlatformException catch (e) {
      print("Failed to get device info: '${e.message}'.");
      return {};
    }
  }
}
