import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/widgets/popup_menu_dots.dart';
import 'package:graduation_app/models/app2.dart';
import 'package:graduation_app/boxes.dart';
import 'package:graduation_app/utils/enums.dart';
import 'package:graduation_app/utils/get_rules.dart';
import 'package:graduation_app/utils/channel_utils.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Applications extends StatefulWidget {
  const Applications({Key? key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  // For Sorting
  Sort? sort = Sort.name;

  // For Searching
  Icon cusIcon = const Icon(appBarIconSearch);
  Widget cusSearchBar = Text('hp2'.tr());
  bool isSearch = false;
  String searchQuery = "";

  List<App2> getApp(Box<App2> box) {
    List<App2> app = isSearch
        ? box.values
            .toList()
            .where((c) => c.appName.toLowerCase().contains(searchQuery))
            .toList()
            .cast<App2>()
        : box.values.toList().cast<App2>();

    switch (sort) {
      case Sort.name:
        app.sort((a, b) => a.appName.compareTo(b.appName));
        break;

      case Sort.other:
        //print("sort other");
        app.sort((a, b) => a.appName.compareTo(b.appName));
        break;

      default:
        app.sort((a, b) => a.appName.compareTo(b.appName));
    }

    return app;
  }

  @override
  void initState() {
    super.initState();

    // sendRules();
    // print(dd);
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
          popupMenuSort(),
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
      ],
    );
  }

  Widget buildListView2() {
    return ValueListenableBuilder<Box<App2>>(
      valueListenable: Boxes.getApp2s().listenable(),
      builder: (context, box, _) {
        List<App2> app2s = getApp(box);

        return Padding(
          padding: const EdgeInsets.all(0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
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

  Widget buildExpansionTiles(int index, App2 app) {
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
            onPressed: () {
              app.allowWifi = !app.allowWifi;
              app.save();
            },
            icon: app.allowWifi
                ? const Icon(applicationsWifiIcon)
                : const Icon(applicationsWifiOffIcon),
          ),
          IconButton(
            onPressed: () {
              app.allowMobileNetwork = !app.allowMobileNetwork;
              app.save();
            },
            icon: app.allowMobileNetwork
                ? const Icon(applicationsCellDataIcon)
                : const Icon(applicationsCellDataOffIcon),
          ),
        ],
      ),
    );
  }

  Widget popupMenuSort() {
    return PopupMenuButton<String>(
      color: Colors.black87,
      icon: const Icon(appBarIconSort),
      onSelected: (String result) {
        switch (result) {
          case 'sort_dropdown_1':
            setState(() {
              sort = Sort.name;
            });
            break;
          case 'sort_dropdown_2':
            setState(() {
              sort = Sort.other;
            });
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          value: 'sort_dropdown_1',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<Sort>(
                value: Sort.name,
                activeColor: appBarDropdownActiveColor,
                groupValue: sort,
                onChanged: (Sort? value) {
                  setState(() {
                    sort = value;
                  });
                },
              ),
              Text('sort_dropdown_1'.tr(), style: textStyle2(15)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'sort_dropdown_2',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<Sort>(
                value: Sort.other,
                activeColor: appBarDropdownActiveColor,
                groupValue: sort,
                onChanged: (Sort? value) {
                  setState(() {
                    sort = value;
                  });
                },
              ),
              Text('sort_dropdown_2'.tr(), style: textStyle2(15)),
            ],
          ),
        ),
      ],
    );
  }
}
