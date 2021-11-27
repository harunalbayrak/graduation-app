import 'package:flutter/material.dart';

const ImageProvider background0 = AssetImage("assets/images/background0.jpg");

Widget buildBackground() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: background0,
        fit: BoxFit.cover,
      ),
    ),
  );
}
