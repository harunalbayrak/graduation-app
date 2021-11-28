import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_app/constants/colors.dart';

Widget buildVerticalBarChart2(List<BarChartGroupData> showingBarGroups) {
  return AspectRatio(
    aspectRatio: 1.5,
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: darkBlue,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 20,
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
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                      margin: 20,
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
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      margin: 8,
                      reservedSize: 28,
                      interval: 1,
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
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    ),
  );
}
