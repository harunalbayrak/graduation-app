import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('mm6'.tr())),
      body: Stack(
        children: [
          buildBackground(),
          buildContainer(),
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: classicBlackGray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile6(context, 'st1'.tr(), generalSettingsIcon, 1),
          buildListTile6(context, 'st2'.tr(), networkSettingsIcon, 2),
          buildListTile6(context, 'st3'.tr(), backupSettingsIcon, 3),
          buildListTile6(context, 'st4'.tr(), advancedSettingsIcon, 4),
          buildListTile6(context, 'st5'.tr(), batterySettingsIcon, 5),
        ],
      ),
    );
  }
}
