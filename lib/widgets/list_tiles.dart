import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/ui/settings/general_settings.dart';
import 'package:graduation_app/ui/settings/network_settings.dart';
import 'package:graduation_app/ui/settings/backup_settings.dart';
import 'package:graduation_app/ui/settings/advanced_settings.dart';
import 'package:graduation_app/ui/settings/battery_settings.dart';
import 'package:graduation_app/utils/page_route_utils.dart';

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

Widget buildListTile4(String str1, String str2, IconData iconData) {
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
    trailing: Icon(
      iconData,
      color: orange,
    ),
  );
}

Widget buildListTile5(String str, Function onChanged, bool isSwitched) {
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
    trailing: Switch(
      value: isSwitched,
      onChanged: (value) {
        onChanged;
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    ),
  );
}

Widget buildListTile6(
    BuildContext context, String str, IconData iconData, int val) {
  return ListTile(
    contentPadding: const EdgeInsets.all(paddingOverall),
    leading: Icon(iconData),
    title: AutoSizeText(
      str,
      style: textStyle2,
    ),
    onTap: () {
      switch (val) {
        case 1:
          pageRoute(context, "/general_settings", const GeneralSettings());
          break;
        case 2:
          pageRoute(context, "/network_settings", const NetworkSettings());
          break;
        case 3:
          pageRoute(context, "/backup_settings", const BackupSettings());
          break;
        case 4:
          pageRoute(context, "/advanced_settings", const AdvancedSettings());
          break;
        case 5:
          pageRoute(context, "/battery_settings", const BatterySettings());
          break;
      }
    },
  );
}
