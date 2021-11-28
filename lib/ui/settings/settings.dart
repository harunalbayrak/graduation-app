import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/list_tiles.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
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
          buildListTile6(context, "General Settings", generalSettingsIcon, 1),
          buildListTile6(context, "Network Settings", networkSettingsIcon, 2),
          buildListTile6(context, "Backup Settings", backupSettingsIcon, 3),
          buildListTile6(context, "Advanced Settings", advancedSettingsIcon, 4),
          buildListTile6(context, "Battery Settings", batterySettingsIcon, 5),
        ],
      ),
    );
  }
}
