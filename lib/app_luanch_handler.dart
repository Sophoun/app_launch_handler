import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLuanchHandler {
  final channel = const MethodChannel("com.sophoun.app_luanch_handler");
  final Function(String result) onResult;

  AppLuanchHandler({required this.onResult}) {
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "launchWithResult":
          if (kDebugMode) {
            print("TAG pkg ${call.arguments}");
          }
          onResult(call.arguments);
          break;
        default:
          throw Exception("Invalid method name : ${call.method}");
      }
    });
  }

  /// Open external app with result
  void launch(String url) {
    // Validate url
    final uri = Uri.tryParse(url);
    if (uri == null) {
      throw Exception("Invalid url");
    }
    // Open external app
    launchUrl(uri);
  }
}
