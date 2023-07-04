import 'flutter_plugin_sample_platform_interface.dart';

class FlutterPluginSample {
  Future<String?> getPlatformVersion() {
    return FlutterPluginSamplePlatform.instance.getPlatformVersion();
  }

  Future<int?> sumInt(int a, int b) {
    return FlutterPluginSamplePlatform.instance.sumInt(a, b);
  }

  Future<int?> httpGetStatus(String url) {
    return FlutterPluginSamplePlatform.instance.httpGetStatus(url);
  }
}
