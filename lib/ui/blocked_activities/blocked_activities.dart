import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities_2.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/utils/page_route_utils.dart';
import 'package:graduation_app/utils/channel_utils.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';
import 'package:graduation_app/models/activity.dart';
import 'package:graduation_app/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hexagon/hexagon.dart';

class BlockedActivities extends StatefulWidget {
  const BlockedActivities({Key? key}) : super(key: key);

  @override
  _BlockedActivitiesState createState() => _BlockedActivitiesState();
}

class _BlockedActivitiesState extends State<BlockedActivities> {
  double textSize2 = 10;

  List<Activity> getActivities(Box<Activity> box) {
    // List<Activity> app = box.values.toList().cast<Activity>();
    List<Activity> app = box.values
        .toList()
        .where((c) => c.isBlocked == true)
        .toList()
        .cast<Activity>();

    return List.from(app.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOnlyDots(context, 'hp3'.tr()),
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
        pageRoute(context, "/blocked_activities2", const BlockedActivities2());
      },
      contentPadding: padding3,
      title: AutoSizeText(activity.host, style: textStyle2(textSize2)),
      subtitle: AutoSizeText(activity.ip, style: textStyle2(textSize2)),
      leading: SizedBox(
        height: 50,
        width: 50,
        child: HexagonWidget.pointy(
          cornerRadius: 8.0,
          width: 100,
          color: lightBlue,
          padding: 4.0,
          child: AutoSizeText(activity.total_7days.toString(), maxLines: 1),
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          activity.isBlocked = false;
          activity.save();
          invokeRemoveBlockedHost(activity.host);
        },
        icon: const Icon(
          blockedActivitiesRemoveIcon,
          color: blockedActivitiesIconColor,
        ),
      ),
    );
  }
}
