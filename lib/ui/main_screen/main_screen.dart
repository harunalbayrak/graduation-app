import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/switch_button.dart';
import 'package:graduation_app/widgets/rectangle_button.dart';
import 'package:graduation_app/widgets/bottom_navbar.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double fontSize1 = 40;
    const double fontSize2 = fontSize1 / 2;
    const double spaceSize1 = 40 * 0.75;
    const double spaceSize2 = spaceSize1 / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage("assets/images/background0.jpg"),
              fit: BoxFit.cover,
            ),
          ),
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
                  RectangleButton(buttonText: "ASD"),
                  SizedBox(width: spaceSize2),
                  RectangleButton(buttonText: "BCD"),
                  SizedBox(width: spaceSize2),
                  RectangleButton(buttonText: "ASDA"),
                ],
              )
            ],
          )),
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
