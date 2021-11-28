import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void pageRoute(BuildContext context, String str, Widget widget) {
  pushNewScreenWithRouteSettings(
    context,
    settings: RouteSettings(name: str),
    screen: widget,
    withNavBar: true,
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
  );
}
