import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';

Widget buildVerticalBarChart2(
    BuildContext context, List<BarChartGroupData> showingBarGroups) {
  double leftPadding = chartLeftPadding(context);
  double topPadding = chartTopPadding(context);
  double sizedBoxWidth = chartIconSizedBox(context);

  return AspectRatio(
    aspectRatio: chartAspectRatio,
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMin)),
      color: darkBlue,
      child: Padding(
        padding: const EdgeInsets.all(paddingMin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: topPadding,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: chart2_MaxY,
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
                      getTextStyles: (context, value) => const TextStyle(
                          color: gray,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      margin: chartLeftMargin(context),
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
              padding: EdgeInsets.fromLTRB(leftPadding, topPadding, 0, 0),
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
              height: topPadding / 2 + 2,
            ),
          ],
        ),
      ),
    ),
  );
}
