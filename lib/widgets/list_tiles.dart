import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget buildListTile1(String str) {
  return ListTile(
    contentPadding: const EdgeInsets.all(paddingOverall),
    leading: const CircleAvatar(
      backgroundImage: NetworkImage(
          "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
    ),
    title: AutoSizeText(
      str,
      style: textStyle2,
    ),
  );
}

Widget buildListTile2(String str, IconData iconData) {
  return ListTile(
    contentPadding: const EdgeInsets.fromLTRB(
        paddingOverall, 0, paddingOverall, paddingOverall),
    trailing: Icon(
      iconData,
      color: gray,
    ),
    title: AutoSizeText(
      str,
      style: textStyle2,
    ),
  );
}

Widget buildListTile3(String str1, String str2) {
  return ListTile(
    contentPadding: const EdgeInsets.fromLTRB(
        paddingOverall, 0, paddingOverall, paddingOverall),
    title: AutoSizeText(
      str1,
      style: textStyle2,
    ),
    subtitle: AutoSizeText(
      str2,
      style: textStyle2,
    ),
  );
}
