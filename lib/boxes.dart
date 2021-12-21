import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:graduation_app/models/app2.dart';
import 'package:graduation_app/models/filter.dart';
import 'package:graduation_app/models/statistic.dart';
import 'package:graduation_app/models/activity.dart';

class Boxes {
  static Box<App2> getApp2s() => Hive.box<App2>('app2s');
  static Box<Filter> getFilters() => Hive.box<Filter>('filters');
  static Box<Statistic> getStatistics() => Hive.box<Statistic>('statistics');
  static Box<Activity> getActivities() => Hive.box<Activity>('activities');
}
