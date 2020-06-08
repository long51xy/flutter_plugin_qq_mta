import 'package:flutter/services.dart';

class QqMta {
  static const MethodChannel _channel =
      const MethodChannel('qq_mta');

  void init({bool debugEnabled}) async {
    Map<String, dynamic> options = {};
    if (debugEnabled != null) {
      options["debugEnabled"] = debugEnabled;
    }
    await _channel.invokeMethod('init', options);
  }

  void trackEvent(String eventName, {Map<String, dynamic> parameters}) async {
    Map<String, dynamic> options = {};
    options["eventName"] = eventName;
    if (parameters != null) {
      options["parameters"] = parameters;
    }
    await _channel.invokeMethod('trackEvent', options);
  }
}
