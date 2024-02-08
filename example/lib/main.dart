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
  final ValueNotifier<String> _result = ValueNotifier("Unknow");

  late AppLuanchHandler applauncher;

  @override
  void initState() {
    super.initState();
    applauncher = AppLuanchHandler(onResult: (result) {
      _result.value = result;
      if (kDebugMode) {
        print("TAG main.dart $result");
      }
    });
  }

  void launchApp() {
    const token = "1680907160063803394";
    applauncher.launch(
        "https://link-uat.princebank.com.kh/sdk?orderNo=$token&appPkg=Y29tLnNvcGhvdW4uYXBwX2x1YW5jaF9oYW5kbGVyX2V4YW1wbGU=&scheme=bXlhcHA=");
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
