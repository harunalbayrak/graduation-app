import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';
import 'package:graduation_app/widgets/padding_light_text.dart';

class Filters2 extends StatefulWidget {
  const Filters2({Key? key}) : super(key: key);

  @override
  _Filters2State createState() => _Filters2State();
}

class _Filters2State extends State<Filters2> {
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
    return Container(
      padding: EdgeInsets.zero,
      decoration: activitiesDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile6(context, "Adware/malware", Icons.dangerous, 0),
          paddingBoldText(context, "Total Domain(Host): 1234"),
          paddingBoldText(context, "Information"),
          paddingLightText(context,
              "Lorem ipsum dolor sit amet, consectetur lorem ipsum ipsum dolor sit amet, consectetur lorem ipsum ipsum dolor sit amet, consectetur lorem ipsum"),
        ],
      ),
    );
  }
}
