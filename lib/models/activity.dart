import 'package:hive/hive.dart';
part 'activity.g.dart';

@HiveType(typeId: 3)
class Activity extends HiveObject {
  @HiveField(0)
  late String application;

  @HiveField(1)
  late String domain;

  @HiveField(2)
  late List<DateTime> times;

  @HiveField(3)
  late bool isBlocked;

  @HiveField(4)
  late int total_1day;

  @HiveField(5)
  late int total_7days;

  @HiveField(6)
  late dynamic appIcon;
}
