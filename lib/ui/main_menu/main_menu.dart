import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/widgets/rectangle_button.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:like_button/like_button.dart';

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
              LikeButton(
                bubblesSize: 200,
                size: 25.h,
                circleColor: const CircleColor(
                  start: Color(0xff00ddff),
                  end: Color(0xff0099cc),
                ),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xFFFFC107),
                  dotSecondaryColor: Color(0xFFFF9800),
                  dotThirdColor: Color(0xFFFF5722),
                  dotLastColor: Color(0xFFF44336),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    mainButtonIcons[7],
                    color: isLiked ? darkBlue : Colors.grey,
                    size: 35.w,
                  );
                },
              ),
              SizedBox(height: space1),
              buildRow(3.w),
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
