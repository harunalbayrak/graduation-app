import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/switch_button.dart';
import 'package:graduation_app/widgets/rectangle_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/widgets/build_background.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    const double fontSize1 = 40;
    const double fontSize2 = fontSize1 / 2;
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
              Column(
                children: const [
                  AutoSizeText("Application",
                      style: TextStyle(
                          fontSize: fontSize1, fontWeight: FontWeight.w700)),
                  AutoSizeText("Deactivated",
                      style: TextStyle(
                          fontSize: fontSize2, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: spaceSize1),
              const SwitchButton(),
              const SizedBox(height: spaceSize1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  RectangleButton(
                      iconData: Icons.filter_list, buttonText: "Filter"),
                  SizedBox(width: spaceSize2),
                  RectangleButton(
                      iconData: Icons.query_stats, buttonText: "Statistics"),
                  SizedBox(width: spaceSize2),
                  RectangleButton(
                      iconData: Icons.settings, buttonText: "Settings"),
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
