import 'package:flutter/material.dart';
import 'package:graduation_app/boxes.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/models/statistic.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/vertical_bar_chart_2.dart';
import 'package:graduation_app/widgets/vertical_bar_chart.dart';
import 'package:graduation_app/ui/statistics/statistics_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late List<BarChartGroupData> showingBarGroups;
  late List<BarChartGroupData> showingBarGroups2;

  @override
  void initState() {
    super.initState();

    final barGroup8 = makeGroupData2(0, 17);
    final barGroup9 = makeGroupData2(1, 14);
    final barGroup10 = makeGroupData2(2, 13);
    final barGroup11 = makeGroupData2(3, 12);
    final barGroup12 = makeGroupData2(4, 10);
    final barGroup13 = makeGroupData2(5, 9);
    final barGroup14 = makeGroupData2(6, 7);

    final items2 = [
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
      barGroup13,
      barGroup14,
    ];

    showingBarGroups2 = items2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'mm5'.tr()),
      body: Stack(
        children: [
          buildBackground(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: padding5,
                  child: AutoSizeText(
                    's1'.tr(),
                    style: textStyle5(17),
                    maxLines: 1,
                  ),
                ),
                const BuildVerticalBarChart0(),
                SizedBox(height: statisticsHeight),
                Padding(
                  padding: padding5,
                  child: AutoSizeText(
                    's2'.tr(args: ['7']),
                    style: textStyle5(17),
                    maxLines: 1,
                  ),
                ),
                buildVerticalBarChart2(context, showingBarGroups2),
                SizedBox(height: statisticsHeight),
                Padding(
                  padding: padding5,
                  child: AutoSizeText(
                    's3'.tr(args: ['7']),
                    style: textStyle5(17),
                    maxLines: 1,
                  ),
                ),
                buildVerticalBarChart2(context, showingBarGroups2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
