import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';
import 'package:graduation_app/widgets/padding_bold_text.dart';
import 'package:graduation_app/constants/text_styles.dart';

class Filters extends StatefulWidget {
  Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activities')),
      body: Stack(
        children: [
          buildBackground(),
          buildContainer(),
        ],
      ),
    );
  }

  Widget buildContainer() {
    bool isSwitched = false;
    void onChange(value) {
      setState(() {
        isSwitched = value;
      });
    }

    return Container(
      padding: EdgeInsets.zero,
      decoration: classicBlackGray,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildListTile5("Adware/Malware", onChange, isSwitched),
        ],
      ),
    );
  }
}
