# shop3

# Shop3.0 Project Documentation
### Overview
Shop3.0 is a modern Flutter e-commerce application designed with clean architecture principles. It features user authentication, product browsing by category, persistent caching, and native platform integration for device information. The project leverages Riverpod for state management, Dio for networking, and GoRouter for navigation.

### Features
User Authentication: Sign up, sign in, and email availability checks.
Product Catalog: Browse products by category, view product details.
Profile Management: View and update user profile.
Persistent Caching: Uses SharedPreferences for local storage of user/session data.
Native Platform Integration: Retrieves device info from iOS using a Flutter platform channel.
State Management: Riverpod for robust, testable state handling.
Navigation: GoRouter for declarative routing.
Responsive UI: Uses flutter_screenutil for adaptive layouts.

### Folder Structure
```
lib/
  core/
    app_config.dart
    repositories/
    services/
    utils/
  features/
    profile/
    shop/
    signin/
    signup/
    splash_screen/
  routes/
  theme.dart
  main.dart
  di_manager.dart
```
### Getting Started
Prerequisites
`Flutter SDK (3.10+ recommended)`
`Dart SDK`
`Xcode (for iOS development)`
`Android Studio (for Android development)`
`CocoaPods (for iOS dependencies)`

### Configure environment variables (optional):
You can set baseUrl and version using Dart environment variables or edit AppConfig directly in the `~/config/dev_config.json`.
See `config/example_config.json` for reference

### Running the App
On iOS
or open the project in Xcode and run on a simulator/device.

On Android
or open the project in Android Studio and run on a simulator/device.

### .vscode
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "shop3",
            "request": "launch",
            "type": "dart",
            "program": "lib/main.dart",
            "args": ["--dart-define-from-file=config/dev_config.json"]
        },
        {
            "name": "shop3 (profile mode)",
            "request": "launch",
            "type": "dart",
            "program": "lib/main.dart",
            "flutterMode": "profile",
            "args": ["--dart-define-from-file=config/staging_config.json"]
        },
        {
            "name": "shop3 (release mode)",
            "request": "launch",
            "type": "dart",
            "program": "lib/main.dart",
            "flutterMode": "release",
             "args": ["--dart-define-from-file=config/prod_config.json"]
        }
    ]
}
```

### Notes
Device Info:
The app uses a platform channel to fetch iOS device information. This is handled in `AppDelegate.swift` and accessed in Dart via `NativeMethodChannelPlatform`.

Caching:
User session and profile data are cached using the CacheService singleton, which wraps `SharedPreferences`.

Dependency Injection:
The app uses `get_it` for service location, configured in `di_manager.dart`.