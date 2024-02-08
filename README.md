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
    applauncher = AppLuanchHandler(onResult: (result) {
      _result.value = result;
    });
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
