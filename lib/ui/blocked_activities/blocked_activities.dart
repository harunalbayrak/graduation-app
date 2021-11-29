import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities_2.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/utils/page_route_utils.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:easy_localization/easy_localization.dart';

class BlockedActivities extends StatefulWidget {
  const BlockedActivities({Key? key}) : super(key: key);

  @override
  _BlockedActivitiesState createState() => _BlockedActivitiesState();
}

class _BlockedActivitiesState extends State<BlockedActivities> {
  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hp3'.tr())),
      body: Stack(
        children: [
          buildBackground(),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.zero,
          decoration: blockedActivitiesDecoration,
          child: buildListTiles(index),
        );
      },
    );
  }

  Widget buildListTiles(index) {
    return ListTile(
      onTap: () {
        pageRoute(context, "/blocked_activities2", const BlockedActivities2());
      },
      contentPadding: const EdgeInsets.fromLTRB(
          blockedActivitiesPadding, 0, blockedActivitiesPadding, 0),
      title: AutoSizeText(titles[index], style: blockedActivitiesTextStyle),
      subtitle:
          AutoSizeText(subtitles[index], style: blockedActivitiesTextStyle),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          blockedActivitiesRemoveIcon,
          color: blockedActivitiesIconColor,
        ),
      ),
    );
  }
}
