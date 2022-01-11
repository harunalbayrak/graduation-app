import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/widgets/popup_menu_dots.dart';
import 'package:graduation_app/boxes.dart';
import 'package:graduation_app/models/activity.dart';

PreferredSizeWidget appBar2_Activities(BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            final box = Boxes.getActivities();
            box.clear();
          },
          child: Icon(CupertinoIcons.trash),
        ),
      ),
      popupMenuDots(context),
    ],
  );
}

PreferredSizeWidget appBar2_BlockedActivities(
    BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            final box = Boxes.getActivities();
            List<Activity> app = box.values
                .toList()
                .where((c) => c.isBlocked == true)
                .toList()
                .cast<Activity>();

            for (int i = 0; i < app.length; i++) {
              app[i].isBlocked = false;
              app[i].save();
            }
          },
          child: Icon(CupertinoIcons.trash),
        ),
      ),
      popupMenuDots(context),
    ],
  );
}
