import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget buildVerticalBarChart2(
    BuildContext context, List<BarChartGroupData> showingBarGroups) {
  double sizedBoxWidth = 4.65.w;

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
                  maxY: barChart2MaxY,
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
                    bottomTitles: SideTitles(showTitles: false),
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
                        } else if (value == 10) {
                          return '25K';
                        } else if (value == 19) {
                          return '30K';
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
            Padding(
              padding: padding8,
              child: Row(
                children: [
                  const Icon(Icons.ac_unit),
                  SizedBox(width: sizedBoxWidth),
                  const Icon(Icons.ac_unit),
                  SizedBox(width: sizedBoxWidth),
                  const Icon(Icons.ac_unit),
                  SizedBox(width: sizedBoxWidth),
                  const Icon(Icons.ac_unit),
                  SizedBox(width: sizedBoxWidth),
                  const Icon(Icons.ac_unit),
                  SizedBox(width: sizedBoxWidth),
                  const Icon(Icons.ac_unit),
                  SizedBox(width: sizedBoxWidth),
                  const Icon(Icons.ac_unit),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    ),
  );
}
