package com.sophoun.app_luanch_handler

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import android.net.Uri
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import android.util.Log
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.Dispatchers

/** AppLuanchHandlerPlugin */
class AppLuanchHandlerPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.sophoun.app_luanch_handler")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    result.notImplemented()
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d("TAG", "onAttachedToActivity: ${binding.activity.intent.data}")
    channel.invokeMethod("launchWithResult", binding.activity.intent.data.toString())
  }

  override fun onDetachedFromActivityForConfigChanges() {
    Log.d("TAG", "onDetachedFromActivityForConfigChanges: ")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
    Log.d("TAG", "onReattachedToActivityForConfigChanges: ")
  }

  override fun onDetachedFromActivity() {
    Log.d("TAG", "onDetachedFromActivity: ")
  }
}
