import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({Key? key}) : super(key: key);

  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'mm6'.tr()),
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
      decoration: blackGrayDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile6(context, 'st1'.tr(), Icons.dangerous, 0),
          buildListTile7('st1_1'.tr()),
          buildListTile3('st1_2'.tr(), "System default"),
          buildListTile3('st1_3'.tr(), "English"),
        ],
      ),
    );
  }
}
