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
flutter create --platforms=android,ios --project-name=simplecalc --no-overwrite .
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

The `flutter create` command generates the native Android and iOS host projects
using your installed SDK. `--no-overwrite` preserves the calculator source and
tests already in this folder. Connect a phone with development mode enabled or
start an emulator before `flutter run`.

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

Flutter and Dart were unavailable in the conversion environment. The Dart
source and tests are supplied, but Flutter analysis, test execution, native
project generation, and mobile builds must run on a machine with the SDK.
