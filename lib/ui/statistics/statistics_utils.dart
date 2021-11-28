import 'package:fl_chart/fl_chart.dart';
import 'package:graduation_app/constants/env.dart';

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      y: y1,
      colors: chart1Colors_1,
      width: statisticsBarWidth,
    ),
    BarChartRodData(
      y: y2,
      colors: chart1Colors_2,
      width: statisticsBarWidth,
    ),
  ]);
}

BarChartGroupData makeGroupData2(int x, double y1) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      y: y1,
      colors: chart2Colors,
      width: statisticsBarWidth,
    ),
  ]);
}
