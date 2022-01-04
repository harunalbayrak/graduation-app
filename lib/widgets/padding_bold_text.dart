import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/paddings.dart';

Widget paddingBoldText(BuildContext context, String str) {
  return Padding(
    padding: padding6,
    child: Text(
      str,
      style: textStyle4(17),
    ),
  );
}
