import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_app/boxes.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/models/statistic.dart';
import 'package:graduation_app/ui/statistics/statistics_utils.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Statistic getStats(Box<Statistic> box) {
  Statistic? stats = box.get('totalAndBlocked');

  if (stats != null) {
    return stats;
  }

  return Statistic();
}

class BuildVerticalBarChart0 extends StatefulWidget {
  const BuildVerticalBarChart0({Key? key}) : super(key: key);

  @override
  _BuildVerticalBarChart0State createState() => _BuildVerticalBarChart0State();
}

class _BuildVerticalBarChart0State extends State<BuildVerticalBarChart0> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Statistic>>(
      valueListenable: Boxes.getStatistics().listenable(),
      builder: (context, box, _) {
        Statistic stats = getStats(box);

        return AspectRatio(
          aspectRatio: chartAspectRatio,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusMin)),
            color: darkBlue,
            child: Padding(
              padding: padding4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: getMaxWithPlus(stats, 10),
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (_a, _b, _c, _d) => null,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: SideTitles(showTitles: false),
                          topTitles: SideTitles(showTitles: false),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(
                                color: gray,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp),
                            margin: 2.5.w,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                case 0:
                                  return 'Mn';
                                case 1:
                                  return 'Te';
                                case 2:
                                  return 'Wd';
                                case 3:
                                  return 'Tu';
                                case 4:
                                  return 'Fr';
                                case 5:
                                  return 'St';
                                case 6:
                                  return 'Sn';
                                default:
                                  return '';
                              }
                            },
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(
                                color: gray,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp),
                            margin: 2.5.w,
                            reservedSize: chartLeftReservedSize,
                            interval: chartLeftInterval,
                            getTitles: (value) {
                              if (value == 0) {
                                return '0';
                              } else if (value == getMaxValueHalf(stats)) {
                                return getMidValue(stats);
                              } else if (value == getMaxValue(stats)) {
                                return getTopLeftValue(stats);
                              } else {
                                return '';
                              }
                            },
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: show(stats),
                        gridData: FlGridData(show: true),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h / 2 + 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<BarChartGroupData> show(Statistic stats) {
    return [
      makeGroupData(0, stats.totalMN.toDouble(), stats.blockedMN.toDouble()),
      makeGroupData(1, stats.totalTU.toDouble(), stats.blockedTU.toDouble()),
      makeGroupData(2, stats.totalWD.toDouble(), stats.blockedWD.toDouble()),
      makeGroupData(3, stats.totalTE.toDouble(), stats.blockedTE.toDouble()),
      makeGroupData(4, stats.totalFR.toDouble(), stats.blockedFR.toDouble()),
      makeGroupData(5, stats.totalST.toDouble(), stats.blockedST.toDouble()),
      makeGroupData(6, stats.totalSN.toDouble(), stats.blockedSN.toDouble()),
    ];
  }

  double? getMaxValue(Statistic stats) {
    double max = 0;

    if (stats.totalMN > max) {
      max = stats.totalMN.toDouble();
    } else if (stats.totalTU > max) {
      max = stats.totalTU.toDouble();
    } else if (stats.totalWD > max) {
      max = stats.totalWD.toDouble();
    } else if (stats.totalTE > max) {
      max = stats.totalTE.toDouble();
    } else if (stats.totalFR > max) {
      max = stats.totalFR.toDouble();
    } else if (stats.totalST > max) {
      max = stats.totalST.toDouble();
    } else if (stats.totalSN > max) {
      max = stats.totalSN.toDouble();
    }

    return max;
  }

  double? getMaxValueHalf(Statistic stats) {
    double? max = getMaxValue(stats);

    if (max != null) {
      max = max / 2;
    }

    return max;
  }

  double? getMaxWithPlus(Statistic stats, double value) {
    double? max = getMaxValue(stats);

    if (max != null) {
      max = max + value;
    }

    return max;
  }

  String getTopLeftValue(Statistic stats) {
    int topLeft = getMaxValue(stats)!.toInt();

    return getValue(topLeft);
  }

  String getMidValue(Statistic stats) {
    int mid = getMaxValueHalf(stats)!.toInt();

    return getValue(mid);
  }

  String getValue(int value) {
    if (value >= 1000) {
      double y = value / 1000;
      int yInt = value ~/ 1000;
      int yUp = y.ceil();
      double floatingNum = (yUp - y) * 10;

      String result =
          yInt.toString() + '.' + floatingNum.toInt().toString() + 'K';
      return result;
    }

    return value.toString();
  }
}
