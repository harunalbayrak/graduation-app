import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

BoxDecoration classicBlackGray = BoxDecoration(
  gradient: const LinearGradient(
    colors: GradientColors.blackGray,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),

  /*
  border: Border(
    top: BorderSide(width: 0.25, color: Colors.black),
    bottom: BorderSide(width: 0.25, color: Colors.black),
  ),
  */
  border: Border.all(width: 0, color: Colors.black38),
  borderRadius: BorderRadius.circular(0),
);
