import 'package:hive/hive.dart';
part 'activity.g.dart';

@HiveType(typeId: 3)
class Activity extends HiveObject {
  @HiveField(0)
  late String application;

  @HiveField(1)
  late String host;

  @HiveField(2)
  late String ip;

  @HiveField(3)
  late List<DateTime> times;

  @HiveField(4)
  late bool isBlocked;

  @HiveField(5)
  late int total_1day;

  @HiveField(6)
  late int total_7days;

  @HiveField(7)
  late dynamic appIcon;
}
