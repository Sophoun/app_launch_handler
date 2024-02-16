import 'dart:io';

class StatusFilter {
  static String apply(String? url) {
    if (url == null) {
      throw Exception("No url found");
    }
    // Parse URL
    final urlToParse =
        url.replaceRange(0, url.indexOf("://"), "").replaceAll("://", "");
    final uri = Uri.tryParse(urlToParse);
    if (uri == null) {
      throw Exception('Invalid url: $url');
    }
    // Extract status from query paramter
    final status = uri.queryParameters["status"];
    if (status == null) {
      throw Exception("No 'status' paramter found in url: $url");
    }

    //******************************************************************
    // This is a flip flop between Android and iOS.
    // Some application that call back to app, just with the status parameter.
    // So different people different idea, that's why we have this flip flop.
    //
    // The below is the different between Android and iOS that we have meet so,
    // if it's not match to your use case DON"T USE IT.
    //
    // Android: 0 = success, 1 = cancel
    // iOS: 0 = cancel, 1 = success
    //
    // But we will unified it as below:
    // Status: 0 = success, 1 = faliure

    if (Platform.isIOS) {
      return status == "1" ? "0" : "1";
    } else if (Platform.isAndroid) {
      return status;
    } else {
      throw Exception("Unsupported platform: ${Platform.operatingSystem}");
    }
  }
}
