import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/ui/filters/filters.dart';
import 'package:graduation_app/ui/statistics/statistics.dart';
import 'package:graduation_app/ui/settings/settings.dart';
import 'package:graduation_app/utils/page_route_utils.dart';

Widget rectangleButton(
    BuildContext context, String str, IconData iconData, int val) {
  var screenSize = MediaQuery.of(context).size;
  var containerWidth = screenSize.width / 6;
  var containerHeight = screenSize.height / 8;
  const double spaceHeight = 15;

  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () {
        switch (val) {
          case 1:
            pageRoute(context, "/filters", const Filters());
            break;
          case 2:
            pageRoute(context, "/statistics", const Statistics());
            break;
          case 3:
            pageRoute(context, "/settings", const Settings());
            break;
        }
      },
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
