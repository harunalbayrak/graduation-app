import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget mainSwitchButton(BuildContext context) {
  double imageW = 28.w;
  double imageH = 28.h;

  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: mainMenuSwitchButtonColorP,
        onPrimary: mainMenuSwitchButtonColorO,
        shape: const CircleBorder(),
      ),
      child: Image.asset('assets/images/image0.png',
          width: imageW, height: imageH),
    ),
  );
}
