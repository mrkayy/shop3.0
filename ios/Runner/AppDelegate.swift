import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   GeneratedPluginRegistrant.register(with: self)
      
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let systemInfoChannel = FlutterMethodChannel(name: "com.example.shop3/systemInfo", binaryMessenger: controller.binaryMessenger)

      systemInfoChannel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "getDeviceInfo" {
            let device = UIDevice.current
            let info: [String: Any?] = [
                "name": device.name,
                "systemName": device.systemName,
                "systemVersion": device.systemVersion,
                "model": device.model,
                "localizedModel": device.localizedModel,
                "identifierForVendor": device.identifierForVendor?.uuidString,
                "batteryLevel": device.batteryLevel,
                "batteryState": device.batteryState.rawValue
            ]
            result(info)
        } else {
            result(FlutterMethodNotImplemented)
        }
          // switch call.method {
            // case "getDeviceInfo": {
            //         let device = UIDevice.current
            //       let info: [String: Any?] = [
            //             "name": device.name,
            //             "systemName": device.systemName,
            //             "systemVersion": device.systemVersion,
            //             "model": device.model,
            //             "localizedModel": device.localizedModel,
            //             "identifierForVendor": device.identifierForVendor?.uuidString,
            //             "batteryLevel": device.batteryLevel,
            //             "batteryState": device.batteryState.rawValue
            //           ]
            //       result(info)
            //     }
            // case "saveStringVal": {
            //     result(FlutterMethodNotImplemented)
            // }
            // case "getStringVal": {
            //     result(FlutterMethodNotImplemented)
            // }
            // case "saveMapVal": {
            //     result(FlutterMethodNotImplemented)
            // }
            // case "getMapVal": {
            //     result(FlutterMethodNotImplemented)
            // }
            // default: result(FlutterMethodNotImplemented)
          // }
      })
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
