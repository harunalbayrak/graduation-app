import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const TextStyle textStyle1 = TextStyle(
  color: white,
);

TextStyle textStyle2(double size) {
  return TextStyle(
    color: gray,
    fontSize: size.sp,
  );
}

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

TextStyle textStyle5(double size) {
  return TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: size.sp,
  );
}
