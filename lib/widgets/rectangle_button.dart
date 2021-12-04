import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/ui/filters/filters.dart';
import 'package:graduation_app/ui/statistics/statistics.dart';
import 'package:graduation_app/ui/settings/settings.dart';
import 'package:graduation_app/utils/page_route_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget rectangleButton(
    BuildContext context, String str, IconData iconData, int val) {
  double iconSize = 6.w;
  double space = 2.h;
  double boxW = 15.5.w;
  double boxH = 12.h;

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
        width: boxW,
        height: boxH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: iconSize, color: gray),
            SizedBox(
              height: space,
            ),
            AutoSizeText(str, maxLines: 1, style: textStyle2(14)),
          ],
        ),
      ),
    ),
  );
}
