import 'package:flutter/services.dart';

import 'window_to_front_platform_interface.dart';

class WindowToFront {
  static const MethodChannel _channel = MethodChannel('window_to_front');
  // Add from here
  static Future<void> activate() {
    return _channel.invokeMethod('activate');
  }

  Future<String?> getPlatformVersion() {
    return WindowToFrontPlatform.instance.getPlatformVersion();
  }
}
