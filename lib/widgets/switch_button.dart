import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

Widget mainSwitchButton(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  var imageWidth = screenSize.width / 3;
  var imageHeight = screenSize.height / 3;

  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: lightBlue,
        onPrimary: Colors.white,
        shape: const CircleBorder(),
      ),
      child: Image.asset('assets/images/image0.png',
          width: imageWidth, height: imageHeight),
    ),
  );
}
