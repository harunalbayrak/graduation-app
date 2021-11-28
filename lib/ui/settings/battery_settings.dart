import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/widgets/list_tiles.dart';

class BatterySettings extends StatefulWidget {
  const BatterySettings({Key? key}) : super(key: key);

  @override
  _BatterySettingsState createState() => _BatterySettingsState();
}

class _BatterySettingsState extends State<BatterySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Settings')),
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
        children: const [
          Text("asd"),
        ],
      ),
    );
  }
}
