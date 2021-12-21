import 'package:hive/hive.dart';
part 'statistic.g.dart';

@HiveType(typeId: 2)
class Statistic extends HiveObject {
  @HiveField(0)
  late int totalMN;

  @HiveField(1)
  late int totalTE;

  @HiveField(2)
  late int totalWD;

  @HiveField(3)
  late int totalTU;

  @HiveField(4)
  late int totalFR;

  @HiveField(5)
  late int totalST;

  @HiveField(6)
  late int totalSN;

  @HiveField(7)
  late int blockedMN;

  @HiveField(8)
  late int blockedTE;

  @HiveField(9)
  late int blockedWD;

  @HiveField(10)
  late int blockedTU;

  @HiveField(11)
  late int blockedFR;

  @HiveField(12)
  late int blockedST;

  @HiveField(13)
  late int blockedSN;

  Statistic(
      [this.totalMN = 0,
      this.totalTE = 0,
      this.totalWD = 0,
      this.totalTU = 0,
      this.totalFR = 0,
      this.totalST = 0,
      this.totalSN = 0,
      this.blockedMN = 0,
      this.blockedTE = 0,
      this.blockedWD = 0,
      this.blockedTU = 0,
      this.blockedFR = 0,
      this.blockedST = 0,
      this.blockedSN = 0]);
}
