import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';
import 'package:graduation_app/models/activity.dart';

class Activities2 extends StatefulWidget {
  Activity activity;

  Activities2({Key? key, required this.activity}) : super(key: key);

  @override
  _Activities2State createState() => _Activities2State();
}

class _Activities2State extends State<Activities2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'hp4'.tr()),
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
    var inputFormat = DateFormat('dd/MM/yyyy - HH:mm:ss');

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
          paddingBoldText(context, 'ac2'.tr()),
          Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
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
          // buildListTile4("www.asdasd.telegram.com",
          //     'ac3'.tr(args: ['18:03:21', '22']), activitiesBlockIcon),
          // buildListTile4("www.asdasd.telegram.com",
          //     'ac3'.tr(args: ['18:03:21', '22']), activitiesBlockIcon),
        ],
      ),
    );
  }
}
