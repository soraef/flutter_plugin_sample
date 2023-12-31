import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_sample/flutter_plugin_sample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterPluginSamplePlugin = FlutterPluginSample();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterPluginSamplePlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            const SumIntWidget(),
            const HttpGetWidget(),
          ],
        ),
      ),
    );
  }
}

class SumIntWidget extends StatefulWidget {
  const SumIntWidget({super.key});

  @override
  State<SumIntWidget> createState() => _SumIntWidgetState();
}

class _SumIntWidgetState extends State<SumIntWidget> {
  int? _platformVersion;
  final _flutterPlugin = FlutterPluginSample();

  @override
  void initState() {
    super.initState();
    _flutterPlugin.sumInt(1, 1).then((value) => setState(() {
          _platformVersion = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Text("1 + 1 = $_platformVersion");
  }
}

class HttpGetWidget extends StatefulWidget {
  const HttpGetWidget({super.key});

  @override
  State<HttpGetWidget> createState() => _HttpGetWidgetState();
}

class _HttpGetWidgetState extends State<HttpGetWidget> {
  int? _platformVersion;
  final _flutterPlugin = FlutterPluginSample();

  @override
  void initState() {
    super.initState();
    _flutterPlugin
        .httpGetStatus("https://google.com")
        .then((value) => setState(() {
              _platformVersion = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Text("https://google.com = $_platformVersion");
  }
}
