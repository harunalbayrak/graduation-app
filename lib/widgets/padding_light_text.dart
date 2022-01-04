import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/paddings.dart';

Widget paddingLightText(BuildContext context, String str) {
  return Padding(
    padding: padding5,
    child: Text(
      str,
      style: textStyle2(15),
    ),
  );
}
