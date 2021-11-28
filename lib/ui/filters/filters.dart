import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  final isSwitcheds = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
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
          decoration: filtersDecoration,
          child: buildListTiles(index),
        );
      },
    );
  }

  Widget buildListTiles(index) {
    return ListTile(
      onTap: () {
        /*
        pushNewScreenWithRouteSettings(
          context,
          settings: const RouteSettings(name: "/blocked_activities2"),
          screen: const Filters2(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        */
      },
      contentPadding: const EdgeInsets.fromLTRB(filtersPaddingLR,
          filtersPaddingTB, filtersPaddingLR, filtersPaddingTB),
      title: AutoSizeText(titles[index], style: textStyle2),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
      ),
      trailing: Switch(
        activeColor: filtersSwitchActiveColor,
        value: isSwitcheds[index],
        onChanged: (value) {
          setState(() {
            isSwitcheds[index] = value;
          });
        },
      ),
    );
  }
}
