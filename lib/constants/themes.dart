import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

final ThemeData denemeTheme = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: const Color(0xff2E4C6D),
  appBarTheme: const AppBarTheme(
    color: darkBlue,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: darkBlue,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      fontSize: 12,
    ),
  ),
);
