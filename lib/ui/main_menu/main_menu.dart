import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/switch_button.dart';
import 'package:graduation_app/widgets/rectangle_button.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  double space1 = 8.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hp1'.tr())),
      body: Stack(
        children: [
          buildBackground(),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTexts(),
              SizedBox(height: space1),
              mainSwitchButton(context),
              SizedBox(height: space1),
              buildRow(mainMenuSpaceSize2),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildTexts() {
    return Column(
      children: [
        AutoSizeText(
          'mm1'.tr(),
          style: textStyle5(24),
          maxLines: 1,
        ),
        AutoSizeText(
          'mm2'.tr(),
          style: textStyle5(16),
          maxLines: 1,
        ),
      ],
    );
  }

  Widget buildRow(double spaceSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        rectangleButton(context, 'mm4'.tr(), mainMenuFiltersIcon, 1),
        SizedBox(width: spaceSize),
        rectangleButton(context, 'mm5'.tr(), mainMenuStatisticsIcon, 2),
        SizedBox(width: spaceSize),
        rectangleButton(context, 'mm6'.tr(), mainMenuSettingsIcon, 3),
      ],
    );
  }
}
