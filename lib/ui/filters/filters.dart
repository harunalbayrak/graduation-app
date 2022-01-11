import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/ui/filters/filters_2.dart';
import 'package:graduation_app/utils/channel_utils.dart';
import 'package:graduation_app/utils/page_route_utils.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/app_bar_only_dots.dart';
import 'package:graduation_app/models/filter.dart';
import 'package:graduation_app/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  double textSize2 = 16;

  List<Filter> getFilter(Box<Filter> box) {
    List<Filter> filter = box.values.toList().cast<Filter>();

    return filter;
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    return ValueListenableBuilder<Box<Filter>>(
      valueListenable: Boxes.getFilters().listenable(),
      builder: (context, box, _) {
        List<Filter> filters = getFilter(box);

        return Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.builder(
            itemCount: filters.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.zero,
                decoration: blackGrayDecoration,
                child: buildListTiles(index, filters[index]),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildListTiles(index, Filter filter) {
    return ListTile(
      onTap: () {
        pageRoute(context, "/filters2", Filters2(filter: filter));
      },
      contentPadding: padding4,
      title: AutoSizeText(filter.name, style: textStyle2(textSize2)),
      leading: Icon(
        IconData(filter.icon, fontFamily: 'MaterialIcons'),
        color: gray,
      ),
      trailing: Switch(
        activeColor: filtersSwitchActiveColor,
        value: filter.isEnable,
        onChanged: (value) {
          setState(() {
            filter.isEnable = !filter.isEnable;
            filter.save();

            if (filter.isEnable) {
              invokeAddHostFile(index.toString());
              invokeReloadVPNWithNewHosts();
            } else {
              invokeRemoveHostFile(index.toString());
              invokeReloadVPNWithNewHosts();
            }
          });
        },
      ),
    );
  }
}
