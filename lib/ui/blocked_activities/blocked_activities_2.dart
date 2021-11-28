import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';

class BlockedActivities2 extends StatefulWidget {
  const BlockedActivities2({Key? key}) : super(key: key);

  @override
  _BlockedActivities2State createState() => _BlockedActivities2State();
}

class _BlockedActivities2State extends State<BlockedActivities2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blocked Activities')),
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
      decoration: blockedActivitiesDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile1("www.telegram.org"),
          paddingBoldText(context, "Actions"),
          buildListTile2("Add to Allowed", blockedActivities2Icon1),
          buildListTile2("Copy to Clipboard", blockedActivities2Icon2),
          paddingBoldText(context, "Information"),
          buildListTile3("Application", "Telegram"),
          buildListTile3("Asd asdas asdad", "Lorem ipsum"),
        ],
      ),
    );
  }
}
