import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_plugin_sample_method_channel.dart';

abstract class FlutterPluginSamplePlatform extends PlatformInterface {
  /// Constructs a FlutterPluginSamplePlatform.
  FlutterPluginSamplePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPluginSamplePlatform _instance =
      MethodChannelFlutterPluginSample();

  /// The default instance of [FlutterPluginSamplePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPluginSample].
  static FlutterPluginSamplePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPluginSamplePlatform] when
  /// they register themselves.
  static set instance(FlutterPluginSamplePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int?> sumInt(int a, int b) {
    throw UnimplementedError('add() has not been implemented.');
  }

  Future<int?> httpGetStatus(String url) {
    throw UnimplementedError('httpGet() has not been implemented.');
  }
}
