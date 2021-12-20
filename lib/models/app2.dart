import 'package:hive/hive.dart';
part 'app2.g.dart';

@HiveType(typeId: 0)
class App2 extends HiveObject {
  @HiveField(0)
  late String appName;

  @HiveField(1)
  late String packageName;

  @HiveField(2)
  late String version;

  @HiveField(3)
  late bool allowWifi;

  @HiveField(4)
  late bool allowMobileNetwork;

  @HiveField(5)
  late bool isInWhitelist;

  @HiveField(6)
  late bool notificationMode;

  @HiveField(7)
  late int totalActivities_7days;

  @HiveField(8)
  late dynamic icon;
}
