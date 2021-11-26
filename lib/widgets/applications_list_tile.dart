import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/colors.dart';

Widget applicationsListTile(IconData iconData, String text1, String text2) {
  return ListTile(
    contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
    leading: Icon(
      iconData,
      color: gray,
    ),
    title: Text(text1, style: textStyle2),
    subtitle: Text(text2, style: textStyle2),
    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
  );
}
