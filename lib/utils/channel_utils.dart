import 'dart:async';

import 'package:flutter/services.dart';
import 'package:graduation_app/utils/get_rules.dart';
import 'package:logger/logger.dart';

const platform = MethodChannel('LOCAL_VPN_CHANNEL');
var logger = Logger(
  printer: PrettyPrinter(),
);

Future<int> invokeInitialRules() async {
  late dynamic wifiRules;
  late dynamic mobileNetworkRules;

  try {
    wifiRules = getWifiRules();
    mobileNetworkRules = getMobileNetworkRules();
  } catch (E) {
    logger.e("Error Code: -1");
    return -1;
  }

  try {
    await platform.invokeMethod('initialRules', <String, dynamic>{
      'wifiRules': wifiRules,
      'mobileNetworkRules': mobileNetworkRules,
    });
  } catch (E) {
    logger.e("Error Code: -2");
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
    logger.e("Error Code: -3");
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
    logger.e("Error Code: -3");
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
    logger.e("Error Code: -3");
    return -3;
  }

  return 0;
}

Future<int> invokeConnectVPN() async {
  try {
    await platform.invokeMethod('connectVPN');
  } catch (E) {
    logger.e("Error Code: -4");
    return -4;
  }
  return 0;
}

Future<int> invokeDisconnectVPN() async {
  try {
    await platform.invokeMethod('disconnectVPN');
  } catch (E) {
    logger.e("Error Code: -5");
    return -5;
  }
  return 0;
}

FutureOr<List<Object?>> invokeGetFromQueue() async {
  List<Object?> data;

  try {
    data = await platform.invokeMethod('getFromQueue');
  } catch (E) {
    logger.e("Error Code: -6");
    return List.of([]);
  }

  return data;
}

Future<int> invokeClearQueue() async {
  try {
    await platform.invokeMethod('clearQueue');
  } catch (E) {
    logger.e("Error Code: -7");
    return -1;
  }
  return 0;
}

int invokeAddBlockedHost(String host) {
  try {
    platform.invokeMethod('addBlockedHost', <String, String>{
      'blockedHost': host,
    });
  } catch (E) {
    logger.e("Error Code: -8");
    return -8;
  }

  return 0;
}

int invokeRemoveBlockedHost(String host) {
  try {
    platform.invokeMethod('removeBlockedHost', <String, String>{
      'blockedHost': host,
    });
  } catch (E) {
    logger.e("Error Code: -8");
    return -8;
  }

  return 0;
}

Future<int> invokeReload() async {
  try {
    await platform.invokeMethod('reload');
  } catch (E) {
    logger.e("Error Code: -9");
    return -1;
  }
  return 0;
}

Future<int> invokeReloadVPNWithNewHosts() async {
  try {
    await platform.invokeMethod('reloadVPNWithNewHosts');
  } catch (E) {
    logger.e("Error Code: -9");
    return -1;
  }
  return 0;
}

int invokeAddHostFile(String which) {
  try {
    platform.invokeMethod('addHostFile', <String, String>{
      'which': which,
    });
  } catch (E) {
    logger.e("Error Code: -10");
    return -1;
  }

  return 0;
}

int invokeRemoveHostFile(String which) {
  try {
    platform.invokeMethod('removeHostFile', <String, String>{
      'which': which,
    });
  } catch (E) {
    logger.e("Error Code: -10");
    return -1;
  }

  return 0;
}
