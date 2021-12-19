import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';

class Activities2 extends StatefulWidget {
  const Activities2({Key? key}) : super(key: key);

  @override
  _Activities2State createState() => _Activities2State();
}

class _Activities2State extends State<Activities2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'hp4'.tr()),
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
          buildListTile1("Telegram"),
          paddingBoldText(context, 'ac1'.tr(args: ['1234', '7'])),
          paddingBoldText(context, 'ac2'.tr()),
          buildListTile4("www.asdasd.telegram.com",
              'ac3'.tr(args: ['18:03:21', '22']), activitiesBlockIcon),
          buildListTile4("www.asdasd.telegram.com",
              'ac3'.tr(args: ['18:03:21', '22']), activitiesBlockIcon),
        ],
      ),
    );
  }
}
