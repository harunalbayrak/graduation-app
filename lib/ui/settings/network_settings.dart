import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';

class NetworkSettings extends StatefulWidget {
  const NetworkSettings({Key? key}) : super(key: key);

  @override
  _NetworkSettingsState createState() => _NetworkSettingsState();
}

class _NetworkSettingsState extends State<NetworkSettings> {
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
          buildListTile6(context, 'st2'.tr(), Icons.dangerous, 0),
        ],
      ),
    );
  }
}
