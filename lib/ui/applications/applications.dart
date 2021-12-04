import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/constants/paddings.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:easy_localization/easy_localization.dart';

class Applications extends StatefulWidget {
  const Applications({Key? key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  final titles = ["List 1", "List 2", "List 3"];
  final isExpandeds = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hp2'.tr())),
      body: Stack(
        children: [
          buildBackground(),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: applicationsDecoration,
            child: buildExpansionTiles(index),
          );
        },
      ),
    );
  }

  Widget buildExpansionTiles(int index) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        setState(() {
          isExpandeds[index] = value;
        });
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
                applicationsExtendedIcon1, 'ap1'.tr(), "com.package.name"),
            buildListTile0(
                applicationsExtendedIcon2, 'ap2'.tr(), "com.package.name"),
          ],
        ),
      ],
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(titles[index], style: textStyle2(15.5)),
          AnimatedRotation(
            turns: isExpandeds[index] ? .5 : 0,
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
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
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
