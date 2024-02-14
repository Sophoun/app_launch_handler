import 'package:app_luanch_handler/status_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLuanchHandler {
  final channel = const MethodChannel("com.sophoun.app_luanch_handler");
  final Function(String result) onResult;

  /// Constructor
  /// @param [onResult] callback function to get full result.
  /// @param [applyStatusFilter] apply status filter to url so you will get only
  /// status code 0 = success, 1 = cancel. Do not apply status filter if you
  /// want to get full result or you want to use your own status filter.
  AppLuanchHandler({
    required this.onResult,
    applyStatusFilter = false,
  }) {
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "launchWithResult":
          if (kDebugMode) {
            print("TAG pkg ${call.arguments}");
          }
          if (applyStatusFilter) {
            onResult(StatusFilter.apply(call.arguments));
          } else {
            onResult(call.arguments);
          }
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
    launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
