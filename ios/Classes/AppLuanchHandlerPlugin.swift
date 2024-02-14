import Flutter
import UIKit

public class AppLuanchHandlerPlugin: NSObject, FlutterPlugin {
    static var channel: FlutterMethodChannel? = nil
  
  public static func register(with registrar: FlutterPluginRegistrar) {
   channel = FlutterMethodChannel(name: "com.sophoun.app_luanch_handler", binaryMessenger: registrar.messenger())
    let instance = AppLuanchHandlerPlugin()
      registrar.addMethodCallDelegate(instance, channel: channel!)
      registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        AppLuanchHandlerPlugin.channel?.invokeMethod("launchWithResult", arguments: url.absoluteString, result: nil)
        return true
    }
}

