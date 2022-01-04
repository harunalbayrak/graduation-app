import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/popup_menu_dots.dart';

PreferredSizeWidget appBarOnlyDots(BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    actions: <Widget>[
      popupMenuDots(context),
    ],
  );
}
