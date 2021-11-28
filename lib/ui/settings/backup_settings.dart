import 'package:flutter/material.dart';
import 'package:graduation_app/widgets/build_background.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/widgets/list_tiles.dart';

class BackupSettings extends StatefulWidget {
  const BackupSettings({Key? key}) : super(key: key);

  @override
  _BackupSettingsState createState() => _BackupSettingsState();
}

class _BackupSettingsState extends State<BackupSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup Settings')),
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
