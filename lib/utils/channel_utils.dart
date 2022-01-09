import 'dart:async';

import 'package:flutter/services.dart';
import 'package:graduation_app/utils/get_rules.dart';
import 'dart:collection';

const platform = MethodChannel('LOCAL_VPN_CHANNEL');

Future<int> invokeInitialRules() async {
  var wifiRules;
  var mobileNetworkRules;

  try {
    wifiRules = getWifiRules();
    mobileNetworkRules = getMobileNetworkRules();
  } catch (E) {
    print("Error Code: -1");
    return -1;
  }

  try {
    await platform.invokeMethod('initialRules', <String, dynamic>{
      'wifiRules': wifiRules,
      'mobileNetworkRules': mobileNetworkRules,
    });
  } catch (E) {
    print("Error Code: -2");
    return -2;
  }

  return 0;
}

int invokeWhitelist(Map<String, dynamic> rule) {
  try {
    platform.invokeMethod('method1', <String, dynamic>{
      'rule': rule,
    });
  } catch (E) {
    print("Error Code: -3");
    return -3;
  }

  return 0;
}

int invokeChangeRule(String package, String networkType, bool rule) {
  try {
    platform.invokeMethod('editRule', <String, dynamic>{
      'package': package,
      'networkType': networkType,
      'ruleBool': rule,
    });
  } catch (E) {
    print("Error Code: -3");
    return -3;
  }

  return 0;
}

int invokeResetOneRule(String rule) {
  try {
    platform.invokeMethod('method1', <String, String>{
      'rule': rule,
    });
  } catch (E) {
    print("Error Code: -3");
    return -3;
  }

  return 0;
}

Future<int> invokeConnectVPN() async {
  try {
    await platform.invokeMethod('connectVPN');
  } catch (E) {
    print("Error Code: -4");
    return -4;
  }
  return 0;
}

Future<int> invokeDisconnectVPN() async {
  try {
    await platform.invokeMethod('disconnectVPN');
  } catch (E) {
    print("Error Code: -5");
    return -5;
  }
  return 0;
}

FutureOr<List<Object?>> invokeGetFromQueue() async {
  List<Object?> data;

  try {
    data = await platform.invokeMethod('getFromQueue');
  } catch (E) {
    print("Error Code: -6");
    return List.of([]);
  }

  return data;
}

Future<int> invokeClearQueue() async {
  try {
    await platform.invokeMethod('clearQueue');
  } catch (E) {
    print("Error Code: -7");
    return -1;
  }
  return 0;
}
