import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

Widget rectangleButton(
    BuildContext context, String str, IconData iconData, Function onPressed) {
  var screenSize = MediaQuery.of(context).size;
  var containerWidth = screenSize.width / 6;
  var containerHeight = screenSize.height / 8;
  const double spaceHeight = 15;

  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: darkBlue,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Container(
        width: containerWidth,
        height: containerHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            const SizedBox(
              height: spaceHeight,
            ),
            Text(str),
          ],
        ),
      ),
    ),
  );
}
