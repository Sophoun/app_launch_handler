# app_luanch_handler

AppLuanchHandler help you easily to handle result from other apps, that result get back via `onNewIntent`

## Getting Started

To use this plugin, add `app_luanch_handler` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Usage

```dart
import 'package:app_luanch_handler/app_luanch_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<String>_result = ValueNotifier("Unknow");

  late AppLuanchHandler applauncher;

  @override
  void initState() {
    super.initState();
    // Register handler
    applauncher = AppLuanchHandler(
      onResult: (result) {
        _result.value = result;
      },
      applyStatusFilter: false, // NOTE!!! If this true, it will return only status code. If your url does not have status code, it will throw an error. Default is false. Please read the doc for more detail.
    );
  }

  @override
  void dispose() {
    applauncher.dispose();
    super.dispose();
  }

  // Launch app that using deeplink.
  void launchApp() {
    applauncher.launch("https://example.com/somethinggggg");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<String>(
                valueListenable: _result,
                builder: (context, value, child) {
                  return Text(value);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  launchApp();
                },
                child: const Text("Luanch"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Handle scheme

If your app need to be hancle result back from external app, don't forget to add your scheme to `AndroidManifest.xml` and `Info.plist`.

### Android

Inside your `AndroidManifest.xml` add this:
in your `<activity>` tag:

```xml
<intent-filter>
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="your_scheme" />
</intent-filter>
```

### iOS

Inside your `Info.plist` add this:

```xml
<key>CFBundleURLTypes</key>
 <array>
  <dict>
   <key>CFBundleURLSchemes</key>
   <array>
    <string>your_scheme</string>
   </array>
  </dict>
 </array>
```

## License

This plugin is released under the MIT license.
