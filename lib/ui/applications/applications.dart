import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/colors.dart';
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
  final double paddingListView = 6.0;
  final double paddingTB = 1.0;
  final int iconDurationMiliseconds = 350;

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
          decoration: classicBlackGray,
          child: Padding(
            padding: EdgeInsets.all(paddingListView),
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
      collapsedIconColor: gray,
      textColor: gray,
      collapsedTextColor: gray,
      iconColor: gray,
      tilePadding:
          EdgeInsets.fromLTRB(paddingListView, paddingTB, 0, paddingTB),
      initiallyExpanded: false,
      children: [
        Column(
          children: [
            applicationsListTile(
                Icons.assistant_direction, "Deneme2", "com.package.name"),
            applicationsListTile(
                Icons.badge_sharp, "Deneme3", "com.package.name"),
          ],
        ),
      ],
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(titles[index]),
          AnimatedRotation(
            turns: isExpandeds[index] ? .5 : 0,
            duration: Duration(milliseconds: iconDurationMiliseconds),
            child: IgnorePointer(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down),
                color: gray,
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
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
