# Simple Calculator

A Flutter/Dart mobile calculator with a soft green interface, large touch
buttons, basic arithmetic, decimals, sign changes, clear, and backspace.
The app uses Flutter's built-in widgets and fonts and works offline.
Operations chain left to right, like a basic pocket calculator.

## Setup and run

Install the [Flutter stable SDK](https://docs.flutter.dev/install) and the
Android development tools. Then, from this directory:

```sh
flutter doctor
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

The Android and iOS host projects are included. Connect a phone with development
mode enabled or start an emulator before `flutter run`.

If Flutter works in VS Code but not your terminal, use the SDK location from
VS Code's `dart.flutterSdkPath` setting, or add that SDK's `bin` directory to
your PATH.

To create an Android release APK:

```sh
flutter build apk --release
```

The APK is written to `build/app/outputs/flutter-apk/app-release.apk`.
Configure your application ID and release signing before store distribution.
iOS builds require macOS with Xcode and appropriate signing:

```sh
flutter build ios
```

## Files

- `lib/main.dart`: mobile interface and optional hardware keyboard controls.
- `lib/calculator.dart`: independent Dart arithmetic and input logic.
- `test/`: arithmetic, touch interaction, and small-screen layout tests.
- `index.html`, `styles.css`, `app.js`, `calculator.js`: original browser version.

## Validation status

Validated with Flutter 3.47.2 and Dart 3.13.2:

- `flutter analyze`: no issues found.
- `flutter test`: all 9 tests passed, including arithmetic, touch controls,
  and small-screen/landscape layouts.
- Android and iOS host projects generated with the Flutter SDK.
- `flutter build apk --debug`: succeeded; APK at
  `build/app/outputs/flutter-apk/app-debug.apk`.

iOS compilation still requires a Mac with Xcode.
