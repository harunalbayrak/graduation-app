import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BlockedActivities extends StatefulWidget {
  BlockedActivities({Key? key}) : super(key: key);

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
      appBar: AppBar(title: const Text('Blocked Activities')),
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage("assets/images/background0.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.zero,
                  child: Container(
                    decoration: classicBlackGray,
                    child: ListTile(
                      title: AutoSizeText(titles[index], style: textStyle2),
                      subtitle:
                          AutoSizeText(subtitles[index], style: textStyle2),
                      leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
