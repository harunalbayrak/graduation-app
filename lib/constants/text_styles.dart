import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

const TextStyle textStyle1 = TextStyle(
  color: white,
);

const TextStyle textStyle2 = TextStyle(
  color: gray,
);

const TextStyle textStyle3 = TextStyle(
  color: lightBlue,
);

TextStyle textStyle4(BuildContext context) {
  var textScaleFactor = MediaQuery.of(context).textScaleFactor;

  return TextStyle(
    color: gray,
    fontWeight: FontWeight.w700,
    fontSize: textScaleFactor * 20,
  );
}

TextStyle textStyle5(BuildContext context, double scale) {
  var textScaleFactor = MediaQuery.of(context).textScaleFactor;

  return TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: textScaleFactor * scale,
  );
}
