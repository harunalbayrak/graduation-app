import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:device_apps/device_apps.dart';
import 'package:graduation_app/widgets/popup_menu_dots.dart';
import 'package:graduation_app/models/app2.dart';
import 'package:graduation_app/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Applications extends StatefulWidget {
  const Applications({Key? key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  bool isLoading = false;

  Icon cusIcon = const Icon(appBarIconSearch);
  Widget cusSearchBar = Text('hp2'.tr());
  final titles = ["List 1", "List 2", "List 3"];
  final isExpandeds = [false, false, false];
  bool isSearch = false;
  String searchQuery = "";

  Future getApps() async {
    List apps =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);

    return apps;
  }

  Future filterApps(String searchQuery) async {
    List apps =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);

    List filteredApps = [];

    for (int i = 0; i < apps.length; ++i) {
      if (apps[i].appName.toLowerCase().contains(searchQuery) ||
          apps[i].appName.contains(searchQuery)) {
        filteredApps.add(apps[i]);
      }
    }

    return filteredApps;
  }

  @override
  void initState() {
    super.initState();

    //refreshApps();
  }

  @override
  void dispose() {
    Hive.box('app2s').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: cusSearchBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (cusIcon.icon == appBarIconSearch) {
                  cusIcon = const Icon(appBarIconSearchCancel);
                  cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ap_search_hint'.tr(),
                      hintStyle: textStyle2(15),
                    ),
                    style: textStyle2(15),
                    onSubmitted: (value) {
                      setState(() {
                        searchQuery = value;
                        isSearch = true;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        isSearch = true;
                      });
                    },
                  );
                } else {
                  cusIcon = const Icon(appBarIconSearch);
                  cusSearchBar = Text('hp2'.tr());
                  setState(() {
                    isSearch = false;
                  });
                }
              });
            },
            icon: cusIcon,
          ),
          popupMenuDots(context),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        buildBackground(),
        buildListView2(),
        /*
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : apps.isEmpty
                ? Container(
                    child:
                        const Text('There is no applications in the database'),
                  )
                : buildListView(),*/
      ],
    );
  }

  Widget buildListView2() {
    return ValueListenableBuilder<Box<App2>>(
      valueListenable: Boxes.getApp2s().listenable(),
      builder: (context, box, _) {
        final List<App2> app2s = box.values.toList().cast<App2>();

        return Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: app2s.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: classicBlackGray,
                child: buildExpansionTiles(index, app2s[index]),
              );
            },
          ),
        );
      },
    );
  }

  /*
  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: classicBlackGray,
            child: buildExpansionTiles(index, apps[index]),
          );
        },
      ),
    );
  }
  */

  Widget buildExpansionTiles(int index, var app) {
    //print(app);

    return ExpansionTile(
      onExpansionChanged: (value) {
        /*setState(() {
          isExpandeds[index] = value;
        });*/
      },
      tilePadding: padding2,
      collapsedIconColor: applicationsTextIconColor,
      textColor: applicationsTextIconColor,
      collapsedTextColor: applicationsTextIconColor,
      iconColor: applicationsTextIconColor,
      initiallyExpanded: false,
      children: [
        Column(
          children: [
            buildListTile0(
                applicationsExtendedIcon1, 'ap1'.tr(), app.packageName),
            buildListTile0(applicationsExtendedIcon2, 'ap2'.tr(), app.version),
            //buildListTile0(
            //    applicationsExtendedIcon2, 'ap2'.tr(), app.category.toString()),
          ],
        ),
      ],
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AutoSizeText(
              app.appName,
              style: textStyle2(
                15.5,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AnimatedRotation(
            turns: false ? .5 : 0,
            duration: const Duration(milliseconds: applicationsIconDuration),
            child: IgnorePointer(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(applicationsDropdownIcon),
                color: applicationsTextIconColor,
              ),
            ),
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
        //child: Icon(Icons.ac_unit),
        child: Image.memory(app.icon),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(applicationsWifiIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(applicationsCellDataIcon),
          ),
        ],
      ),
    );
  }
}
