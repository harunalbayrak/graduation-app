import 'package:graduation_app/boxes.dart';
import 'package:graduation_app/models/app2.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

dynamic getWifiRules() {
  var packagesAllowWifi = <String, bool>{};

  List<App2> app2s = Boxes.getApp2s().values.toList().cast<App2>();
  for (int i = 0; i < app2s.length; i++) {
    var value1 = {app2s[i].packageName: app2s[i].allowWifi};

    try {
      packagesAllowWifi.addAll(value1);
    } catch (E) {
      logger.e("Error getWifiRules");
    }
  }

  return packagesAllowWifi;
}

dynamic getMobileNetworkRules() {
  var packagesAllowMobileNetwork = <String, bool>{};

  List<App2> app2s = Boxes.getApp2s().values.toList().cast<App2>();
  for (int i = 0; i < app2s.length; i++) {
    var value2 = {app2s[i].packageName: app2s[i].allowMobileNetwork};

    try {
      packagesAllowMobileNetwork.addAll(value2);
    } catch (E) {
      logger.e("Error getMobileNetworkRules");
    }
  }

  return packagesAllowMobileNetwork;
}
