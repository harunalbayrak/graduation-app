import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

class RectangleButton extends StatelessWidget {
  const RectangleButton({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSize = screenSize.height / 18;
    const double spaceHeight = 15;

    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: darkBlue,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Container(
          width: screenSize.width / 6,
          height: screenSize.height / 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/image0.png',
                  height: imageSize, width: imageSize),
              const SizedBox(
                height: spaceHeight,
              ),
              Text(buttonText),
            ],
          ),
        ),
      ),
    );
  }
}
