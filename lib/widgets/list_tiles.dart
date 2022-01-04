import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/ui/settings/general_settings.dart';
import 'package:graduation_app/ui/settings/network_settings.dart';
import 'package:graduation_app/ui/settings/backup_settings.dart';
import 'package:graduation_app/ui/settings/advanced_settings.dart';
import 'package:graduation_app/ui/settings/battery_settings.dart';
import 'package:graduation_app/utils/page_route_utils.dart';

double textSize2 = 15;

Widget buildListTile0(IconData iconData, String text1, String text2) {
  return ListTile(
    contentPadding: padding1,
    leading: Icon(
      iconData,
      color: gray,
    ),
    title: Text(text1, style: textStyle2(textSize2)),
    subtitle: Text(text2, style: textStyle2(textSize2)),
    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
  );
}

Widget buildListTile1(String str) {
  return ListTile(
    contentPadding: padding6,
    leading: const CircleAvatar(
      backgroundImage: NetworkImage(
          "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
    ),
    title: AutoSizeText(
      str,
      style: textStyle2(textSize2),
    ),
  );
}

Widget buildListTile2(String str, IconData iconData, {double textSize2 = 15}) {
  return ListTile(
    contentPadding: padding9,
    trailing: Icon(
      iconData,
      color: gray,
    ),
    title: AutoSizeText(
      str,
      style: textStyle2(textSize2),
    ),
  );
}

Widget buildListTile3(String str1, String str2) {
  return ListTile(
    contentPadding: padding7,
    title: AutoSizeText(
      str1,
      style: textStyle2(textSize2),
    ),
    subtitle: AutoSizeText(
      str2,
      style: textStyle2(textSize2),
    ),
  );
}

Widget buildListTile4(String str1, String str2, IconData iconData,
    {double textSize2 = 15}) {
  return ListTile(
    contentPadding: padding9,
    title: AutoSizeText(
      str1,
      style: textStyle2(textSize2),
    ),
    subtitle: AutoSizeText(
      str2,
      style: textStyle2(textSize2),
    ),
    trailing: Icon(
      iconData,
      color: orange,
    ),
  );
}

Widget buildListTile5(String str, Function onChanged, bool isSwitched) {
  return ListTile(
    contentPadding: padding7,
    leading: const CircleAvatar(
      backgroundImage: NetworkImage(
          "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
    ),
    title: AutoSizeText(
      str,
      style: textStyle2(textSize2),
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
    BuildContext context, String str, IconData iconData, int val,
    {double textSize2 = 15}) {
  return ListTile(
    contentPadding: padding6,
    leading: Icon(iconData, color: gray, size: 30),
    title: Text(
      str,
      style: textStyle2(textSize2),
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
        default:
          break;
      }
    },
  );
}

Widget buildListTile7(String str) {
  return ListTile(
    contentPadding: padding7,
    title: AutoSizeText(
      str,
      style: textStyle2(textSize2),
    ),
  );
}
