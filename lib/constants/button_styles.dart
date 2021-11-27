import 'package:flutter/material.dart';

const Color blue = Color(0xff396EB0);

final ButtonStyle buttonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
  overlayColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered)) {
        return Colors.blue.withOpacity(0.04);
      }
      if (states.contains(MaterialState.focused) ||
          states.contains(MaterialState.pressed)) {
        return Colors.blue.withOpacity(0.12);
      }
      return null; // Defer to the widget's default.
    },
  ),
);
