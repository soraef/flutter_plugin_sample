package com.example.flutter_plugin_sample

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import okhttp3.*
import java.io.IOException

/** FlutterPluginSamplePlugin */
class FlutterPluginSamplePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_plugin_sample")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "sumInt") {
      val a = call.argument<Int>("a")
      val b = call.argument<Int>("b")

      if (a == null || b == null) {
        result.error("ARGUMENT_ERROR", "a or b is null", null)
      } else {
        result.success(a + b)
      } 
    } else if(call.method == "httpGetStatus") {
      val url: String? = call.argument<String>("url")
      if (url == null) {
        result.error("ARGUMENT_ERROR", "url is null", null)
      } else {
        val request = Request.Builder().url(url).build()
        val client: OkHttpClient = OkHttpClient()

        client.newCall(request).enqueue(object : Callback {
          override fun onFailure(call: Call, e: IOException) {
            result.error("ARGUMENT_ERROR", "url is null", null)
          }
          override fun onResponse(call: Call, response: Response) {
            result.success(response.code)
          }
        })

      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
