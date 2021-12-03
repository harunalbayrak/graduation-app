import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';
import 'package:graduation_app/widgets/padding_light_text.dart';
import 'package:easy_localization/easy_localization.dart';

class Filters2 extends StatefulWidget {
  const Filters2({Key? key}) : super(key: key);

  @override
  _Filters2State createState() => _Filters2State();
}

class _Filters2State extends State<Filters2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('mm4'.tr())),
      body: Stack(
        children: [
          buildBackground(),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildListView() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: activitiesDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile6(context, 'f1'.tr(), Icons.dangerous, 0),
          paddingBoldText(context, 'f2'.tr(args: ['1234'])),
          paddingBoldText(context, 'f3'.tr()),
          paddingLightText(context, 'f4'.tr()),
        ],
      ),
    );
  }
}
