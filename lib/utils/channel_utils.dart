import 'package:flutter/services.dart';
import 'package:graduation_app/utils/get_rules.dart';

const platform = MethodChannel('LOCAL_VPN_CHANNEL');

int invokeRules() {
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
    platform.invokeMethod('method0', <String, dynamic>{
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

int invokeWifiRule(Map<String, dynamic> rule) {
  try {
    platform.invokeMethod('method1', <String, dynamic>{
      'rule': rule,
      'networkType': "Wifi",
    });
  } catch (E) {
    print("Error Code: -3");
    return -3;
  }

  return 0;
}

int invokeMobileNetworkRule(Map<String, dynamic> rule) {
  try {
    platform.invokeMethod('method1', <String, dynamic>{
      'rule': rule,
      'networkType': "MobileNetwork",
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
