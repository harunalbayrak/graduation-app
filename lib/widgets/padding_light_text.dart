import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';

Widget paddingLightText(BuildContext context, String str) {
  return Padding(
    padding: const EdgeInsets.all(paddingOverall),
    child: Text(
      str,
      style: textStyle2(15),
    ),
  );
}
