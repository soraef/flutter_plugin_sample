import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_plugin_sample/flutter_plugin_sample.dart';
import 'package:flutter_plugin_sample/flutter_plugin_sample_platform_interface.dart';
import 'package:flutter_plugin_sample/flutter_plugin_sample_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPluginSamplePlatform
    with MockPlatformInterfaceMixin
    implements FlutterPluginSamplePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> sumInt(int a, int b) {
    // TODO: implement sumInt
    throw UnimplementedError();
  }

  @override
  Future<int?> httpGetStatus(String url) {
    // TODO: implement httpGetStatus
    throw UnimplementedError();
  }
}

void main() {
  final FlutterPluginSamplePlatform initialPlatform =
      FlutterPluginSamplePlatform.instance;

  test('$MethodChannelFlutterPluginSample is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPluginSample>());
  });

  test('getPlatformVersion', () async {
    FlutterPluginSample flutterPluginSamplePlugin = FlutterPluginSample();
    MockFlutterPluginSamplePlatform fakePlatform =
        MockFlutterPluginSamplePlatform();
    FlutterPluginSamplePlatform.instance = fakePlatform;

    expect(await flutterPluginSamplePlugin.getPlatformVersion(), '42');
  });
}
