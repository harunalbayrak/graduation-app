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

int invokeOneRule(Map<String, dynamic> rule) {
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

Future<int> invokeConnectVPN() async {
  try {
    var value = await platform.invokeMethod('connectVPN');
  } catch (e) {
    print("Error Code: -4");
    return -4;
  }
  return 0;
}
