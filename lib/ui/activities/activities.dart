import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduation_app/constants/colors.dart';

class Activities extends StatefulWidget {
  Activities({Key? key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
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
          buildBackground(),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildBackground() {
    return const Positioned.fill(
      child: Image(
        image: AssetImage("assets/images/background0.jpg"),
        fit: BoxFit.cover,
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
          child: buildListTiles(index),
        );
      },
    );
  }

  Widget buildListTiles(index) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      title: AutoSizeText(titles[index], style: textStyle2),
      subtitle: AutoSizeText(subtitles[index], style: textStyle2),
      leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.edit,
          color: gray,
        ),
      ),
    );
  }
}
