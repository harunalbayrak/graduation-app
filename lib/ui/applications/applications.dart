import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/applications_list_tile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/widgets/build_background.dart';

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
      appBar: AppBar(title: const Text('Applications')),
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
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.all(applicationsPaddingLW),
            child: buildExpansionTiles(index),
          ),
        );
      },
    );
  }

  Widget buildExpansionTiles(int index) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        setState(() {
          isExpandeds[index] = value;
        });
      },
      collapsedIconColor: applicationsTextIconColor,
      textColor: applicationsTextIconColor,
      collapsedTextColor: applicationsTextIconColor,
      iconColor: applicationsTextIconColor,
      tilePadding: const EdgeInsets.fromLTRB(applicationsPaddingLW,
          applicationsPaddingTB, 0, applicationsPaddingTB),
      initiallyExpanded: false,
      children: [
        Column(
          children: [
            applicationsListTile(
                applicationsExtendedIcon1, "Deneme2", "com.package.name"),
            applicationsListTile(
                applicationsExtendedIcon2, "Deneme3", "com.package.name"),
          ],
        ),
      ],
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(titles[index]),
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
