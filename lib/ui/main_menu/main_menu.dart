import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/switch_button.dart';
import 'package:graduation_app/widgets/rectangle_button.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  void onPressedFilters() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    const double spaceSize1 = 40 * 0.75;
    const double spaceSize2 = spaceSize1 / 2;

    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Stack(
        children: [
          buildBackground(),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTexts(),
              const SizedBox(height: spaceSize1),
              mainSwitchButton(context),
              const SizedBox(height: spaceSize1),
              buildRow(spaceSize2),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildTexts() {
    return Column(
      children: [
        AutoSizeText("Application", style: textStyle5(context, 40)),
        AutoSizeText("Deactivated", style: textStyle5(context, 20)),
      ],
    );
  }

  Widget buildRow(double spaceSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        rectangleButton(context, "Filters", mainMenuFiltersIcon, 1),
        SizedBox(width: spaceSize),
        rectangleButton(context, "Statistics", mainMenuStatisticsIcon, 2),
        SizedBox(width: spaceSize),
        rectangleButton(context, "Settings", mainMenuSettingsIcon, 3),
      ],
    );
  }
}
