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
import io.flutter.plugin.common.PluginRegistry.NewIntentListener
import android.content.Intent
import android.app.Activity

/** AppLuanchHandlerPlugin */
class AppLuanchHandlerPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, NewIntentListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var flutterBinding: ActivityPluginBinding? = null
  private var activity: Activity? = null
  
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
    flutterBinding = binding
    activity = binding.activity
    binding.addOnNewIntentListener(this)
    binding.activity.intent?.let { onNewIntent(it) }
  }

  override fun onDetachedFromActivityForConfigChanges() {
    Log.d("TAG", "onDetachedFromActivityForConfigChanges: ")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    Log.d("TAG", "onReattachedToActivityForConfigChanges: ")
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    Log.d("TAG", "onDetachedFromActivity: ")
    flutterBinding?.removeOnNewIntentListener(this)
    flutterBinding = null
    activity = null
  }

  override fun onNewIntent(intent: Intent): Boolean {
    Log.d("TAG", "onNewIntent: ${intent.data}")
    if(intent.data == null) return false
    channel.invokeMethod("launchWithResult", intent.data.toString())
    return true
  }
}
