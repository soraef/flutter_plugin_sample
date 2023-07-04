import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_plugin_sample_platform_interface.dart';

/// An implementation of [FlutterPluginSamplePlatform] that uses method channels.
class MethodChannelFlutterPluginSample extends FlutterPluginSamplePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_plugin_sample');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> sumInt(int a, int b) async {
    final result = await methodChannel.invokeMethod<int>('sumInt', {
      'a': a,
      'b': b,
    });
    return result;
  }

  @override
  Future<int?> httpGetStatus(String url) async {
    final result = await methodChannel.invokeMethod<int>('httpGetStatus', {
      'url': url,
    });
    return result;
  }
}
