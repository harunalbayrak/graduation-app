import 'package:hive/hive.dart';
part 'filter.g.dart';

@HiveType(typeId: 0)
class Filter extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String information;

  @HiveField(2)
  late dynamic icon;

  @HiveField(3)
  late bool isEnable;
}
