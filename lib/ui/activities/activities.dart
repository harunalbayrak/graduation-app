import 'package:flutter/material.dart';
import 'package:graduation_app/ui/activities/activities_2.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/models/activity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/utils/page_route_utils.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';
import 'package:graduation_app/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  double textSize2 = 10;

  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];

  List<Activity> getActivities(Box<Activity> box) {
    List<Activity> app = box.values.toList().cast<Activity>();

    return app;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'hp4'.tr()),
      body: Stack(
        children: [
          buildBackground(),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildListView() {
    return ValueListenableBuilder<Box<Activity>>(
      valueListenable: Boxes.getActivities().listenable(),
      builder: (context, box, _) {
        List<Activity> activities = getActivities(box);

        return Padding(
          padding: const EdgeInsets.all(0),
          child: buildListViewBuilder(activities),
        );
      },
    );
  }

  Widget buildListViewBuilder(List<Activity> activities) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.zero,
          decoration: blackGrayDecoration,
          child: buildListTiles(activities[index]),
        );
      },
    );
  }

  Widget buildListTiles(Activity activity) {
    return ListTile(
      onTap: () {
        pageRoute(context, "/blocked_activities2", const Activities2());
      },
      contentPadding: padding3,
      title: AutoSizeText(activity.host, style: textStyle2(textSize2)),
      subtitle: AutoSizeText(activity.ip, style: textStyle2(textSize2)),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          activitiesBlockIcon,
          color: activitiesIconColor,
        ),
      ),
    );
  }
}
