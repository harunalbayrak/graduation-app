import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageWidth = screenSize.width / 3;
    var imageHeight = screenSize.height / 3;

    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: lightBlue,
          onPrimary: Colors.white,
          shape: const CircleBorder(),
        ),
        child: Image.asset('assets/images/image0.png',
            width: imageWidth, height: imageHeight),
      ),
    );
  }
}
