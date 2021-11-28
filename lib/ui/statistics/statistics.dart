import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/vertical_bar_chart_2.dart';
import 'package:graduation_app/widgets/vertical_bar_chart.dart';
import 'package:fl_chart/fl_chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final double width = 7;
  late List<BarChartGroupData> showingBarGroups;
  late List<BarChartGroupData> showingBarGroups2;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final barGroup8 = makeGroupData2(0, 17);
    final barGroup9 = makeGroupData2(1, 14);
    final barGroup10 = makeGroupData2(2, 13);
    final barGroup11 = makeGroupData2(3, 12);
    final barGroup12 = makeGroupData2(4, 10);
    final barGroup13 = makeGroupData2(5, 9);
    final barGroup14 = makeGroupData2(6, 7);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    final items2 = [
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
      barGroup13,
      barGroup14,
    ];

    showingBarGroups = items;
    showingBarGroups2 = items2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: Stack(
        children: [
          buildBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(paddingOverall),
                child: Text(
                  "Total/Blocked Activities per day",
                  style: textStyle5(context, 20),
                ),
              ),
              buildVerticalBarChart(context, showingBarGroups),
              Padding(
                padding: const EdgeInsets.all(paddingOverall),
                child: Text(
                  "Most Blocked Apps (Last 7 Days)",
                  style: textStyle5(context, 20),
                ),
              ),
              buildVerticalBarChart2(context, showingBarGroups2),
            ],
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [lightBlue, orange],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [lightBlue, blue],
        width: width,
      ),
    ]);
  }

  BarChartGroupData makeGroupData2(int x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [lightBlue, orange],
        width: width,
      ),
    ]);
  }
}
