import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/utils/channel_utils.dart';
import 'package:graduation_app/widgets/popup_menu_dots.dart';
import 'package:graduation_app/boxes.dart';
import 'package:graduation_app/models/activity.dart';

PreferredSizeWidget appBar2Activities(BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            final box = Boxes.getActivities();
            List<Activity> app = box.values
                .toList()
                .where((c) => c.isBlocked == false)
                .toList()
                .cast<Activity>();

            for (int i = 0; i < app.length; i++) {
              box.delete(app[i].key);
            }

            // invokeReload();
          },
          child: const Icon(CupertinoIcons.trash),
        ),
      ),
      popupMenuDots(context),
    ],
  );
}

PreferredSizeWidget appBar2BlockedActivities(
    BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
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
              invokeRemoveBlockedHost(app[i].host);
            }

            invokeReload();
          },
          child: const Icon(CupertinoIcons.trash),
        ),
      ),
      popupMenuDots(context),
    ],
  );
}
