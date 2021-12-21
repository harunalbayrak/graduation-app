import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/models/filter.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';
import 'package:graduation_app/widgets/padding_light_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';

class Filters2 extends StatefulWidget {
  Filter? filter;

  Filters2({Key? key, @required this.filter}) : super(key: key);

  @override
  _Filters2State createState() => _Filters2State();
}

class _Filters2State extends State<Filters2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'mm4'.tr()),
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
      decoration: blackGrayDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile6(context, widget.filter!.name,
              IconData(widget.filter!.icon, fontFamily: 'MaterialIcons'), 0,
              textSize2: 18),
          paddingBoldText(context, 'f2'.tr(args: ['1234'])),
          paddingBoldText(context, 'f3'.tr()),
          paddingLightText(context, widget.filter!.information),
        ],
      ),
    );
  }
}
