import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:easy_localization/easy_localization.dart';

class AdvancedSettings extends StatefulWidget {
  const AdvancedSettings({Key? key}) : super(key: key);

  @override
  _AdvancedSettingsState createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettings> {
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
      decoration: activitiesDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile6(context, 'st4'.tr(), Icons.dangerous, 0),
        ],
      ),
    );
  }
}
