import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BlockedActivities2 extends StatefulWidget {
  BlockedActivities2({Key? key}) : super(key: key);

  @override
  _BlockedActivities2State createState() => _BlockedActivities2State();
}

class _BlockedActivities2State extends State<BlockedActivities2> {
  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  final double paddingListTile = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blocked Activities')),
      body: Stack(
        children: [
          buildBackground(),
          buildContainer(),
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: classicBlackGray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAListTile1("www.telegram.org"),
          paddingBoldText("Actions"),
          buildAListTile2("Add to Allowed", Icons.done),
          buildAListTile2("Copy to Clipboard", Icons.copy_all),
          paddingBoldText("Information"),
          buildAListTile3("Application", "Telegram"),
          buildAListTile3("Asd asdas asdad", "Lorem ipsum"),
        ],
      ),
    );
  }

  Widget buildAListTile1(String str) {
    return ListTile(
      contentPadding: EdgeInsets.all(paddingListTile),
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1547721064-da6cfb341d50"),
      ),
      title: AutoSizeText(
        str,
        style: textStyle2,
      ),
    );
  }

  Widget paddingBoldText(String str) {
    return Padding(
      padding: EdgeInsets.all(paddingListTile),
      child: Text(
        str,
        style: textStyle4(context),
      ),
    );
  }

  Widget buildAListTile2(String str, IconData iconData) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(
          paddingListTile, 0, paddingListTile, paddingListTile),
      trailing: Icon(
        iconData,
        color: gray,
      ),
      title: AutoSizeText(
        str,
        style: textStyle2,
      ),
    );
  }

  Widget buildAListTile3(String str1, String str2) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(
          paddingListTile, 0, paddingListTile, paddingListTile),
      title: AutoSizeText(
        str1,
        style: textStyle2,
      ),
      subtitle: AutoSizeText(
        str2,
        style: textStyle2,
      ),
    );
  }
}
