import 'dart:async';

import 'package:flutter/services.dart';

class GlWifiInfo {
  static const MethodChannel _channel =
      const MethodChannel('gl_wifi_info');

  static Future<String> get wifiIp async {
    final String ip = await _channel.invokeMethod('getWifiIp');
    return ip;
  }
}
