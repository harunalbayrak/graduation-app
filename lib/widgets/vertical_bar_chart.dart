import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget buildVerticalBarChart(
    BuildContext context, List<BarChartGroupData> showingBarGroups) {
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
                  maxY: barChart1MaxY,
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
                      getTextStyles: (context, value) => const TextStyle(
                          color: gray,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                      margin: chartLeftMargin(context),
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
                      getTextStyles: (context, value) => const TextStyle(
                          color: gray,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      margin: chartLeftMargin(context),
                      reservedSize: chartLeftReservedSize,
                      interval: chartLeftInterval,
                      getTitles: (value) {
                        if (value == 0) {
                          return '1K';
                        } else if (value == 10) {
                          return '5K';
                        } else if (value == 19) {
                          return '10K';
                        } else {
                          return '';
                        }
                      },
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
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
}
