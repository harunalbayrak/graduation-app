import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';

class Activities2 extends StatefulWidget {
  const Activities2({Key? key}) : super(key: key);

  @override
  _Activities2State createState() => _Activities2State();
}

class _Activities2State extends State<Activities2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activities')),
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
          buildListTile1("Telegram"),
          paddingBoldText(context, "Total Activities: 1234 (Last 7 days)"),
          paddingBoldText(context, "Actions"),
          buildListTile4("www.asdasd.telegram.com",
              "Time: 18:03:21 (22 seconds ago)", activitiesBlockIcon),
          buildListTile4("www.asdasd.telegram.com",
              "Time: 18:03:21 (22 seconds ago)", activitiesBlockIcon),
        ],
      ),
    );
  }
}
