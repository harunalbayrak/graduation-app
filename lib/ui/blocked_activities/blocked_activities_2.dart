import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';
import 'package:graduation_app/models/activity.dart';

// ignore: must_be_immutable
class BlockedActivities2 extends StatefulWidget {
  Activity activity;

  BlockedActivities2({Key? key, required this.activity}) : super(key: key);

  @override
  _BlockedActivities2State createState() => _BlockedActivities2State();
}

class _BlockedActivities2State extends State<BlockedActivities2> {
  var inputFormat = DateFormat('dd/MM/yyyy - HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'hp3'.tr()),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            buildBackground(),
            buildContainer(),
          ],
        ),
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
          buildListTile1(
            widget.activity.total_7days.toString(),
            widget.activity.host,
            widget.activity.isBlocked,
          ),
          paddingBoldText(context,
              'ac1'.tr(args: [widget.activity.total_7days.toString(), '7'])),
          paddingBoldText(context, 'ba1'.tr()),
          buildListTile2('ba2'.tr(), blockedActivities2Icon1, textSize2: 16),
          buildListTile2('ba3'.tr(), blockedActivities2Icon2, textSize2: 16),
          Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: widget.activity.times.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.zero,
                  decoration: blackGrayDecoration,
                  child: buildListTile4(
                      widget.activity.host.toString(),
                      inputFormat
                          .format(widget.activity.times.elementAt(index))
                          .toString(),
                      activitiesBlockIcon),
                );
              },
            ),
          ),
          // paddingBoldText(context, 'ba4'.tr()),
          // buildListTile3("Application", "Telegram"),
          // buildListTile3("Asd asdas asdad", "Lorem ipsum"),
        ],
      ),
    );
  }
}
