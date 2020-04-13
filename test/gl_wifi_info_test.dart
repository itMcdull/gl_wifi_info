import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gl_wifi_info/gl_wifi_info.dart';

void main() {
  const MethodChannel channel = MethodChannel('gl_wifi_info');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GlWifiInfo.wifiIp, '42');
  });
}
