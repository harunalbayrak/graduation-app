import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:graduation_app/ui/filters/filters.dart';
import 'package:graduation_app/ui/statistics/statistics.dart';
import 'package:graduation_app/ui/settings/settings.dart';

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
            pushNewScreenWithRouteSettings(
              context,
              settings: const RouteSettings(name: "/filters"),
              screen: const Filters(),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
            break;
          case 2:
            pushNewScreenWithRouteSettings(
              context,
              settings: const RouteSettings(name: "/statistics"),
              screen: const Statistics(),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
            break;
          case 3:
            pushNewScreenWithRouteSettings(
              context,
              settings: const RouteSettings(name: "/settings"),
              screen: const Settings(),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
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
