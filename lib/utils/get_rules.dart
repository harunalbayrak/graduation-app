import 'package:graduation_app/boxes.dart';
import 'package:graduation_app/models/app2.dart';

dynamic getWifiRules() {
  var packagesAllowWifi = <String, bool>{};

  List<App2> app2s = Boxes.getApp2s().values.toList().cast<App2>();
  for (int i = 0; i < app2s.length; i++) {
    var value1 = {app2s[i].packageName: app2s[i].allowWifi};

    packagesAllowWifi.addAll(value1);
  }

  return packagesAllowWifi;
}

dynamic getMobileNetworkRules() {
  var packagesAllowMobileNetwork = <String, bool>{};

  List<App2> app2s = Boxes.getApp2s().values.toList().cast<App2>();
  for (int i = 0; i < app2s.length; i++) {
    var value2 = {app2s[i].packageName: app2s[i].allowMobileNetwork};

    packagesAllowMobileNetwork.addAll(value2);
  }

  return packagesAllowMobileNetwork;
}
