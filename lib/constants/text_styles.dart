import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

TextStyle textStyle5(double size) {
  return TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: size.sp,
  );
}

TextStyle textStyle6(BuildContext context, int scale) {
  var textScaleFactor = MediaQuery.of(context).textScaleFactor;

  return TextStyle(
    color: gray,
    fontSize: textScaleFactor * scale,
  );
}

TextStyle textStyle7(double size) {
  return TextStyle(
    color: gray,
    fontSize: size.sp,
  );
}
