import 'package:flutter/material.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/widgets/list_tiles.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
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
