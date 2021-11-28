import 'package:flutter/material.dart';
import 'package:graduation_app/constants/colors.dart';

const double paddingMin = 8.0;
const double paddingOverall = 12.0;

const double borderRadiusMin = 4.0;

const double statisticsBarWidth = 7;
const double chartAspectRatio = 1.5;
const double chartLeftInterval = 1;
const double chartLeftReservedSize = 28;
const List<Color> chart1Colors_1 = [lightBlue, orange];
const List<Color> chart1Colors_2 = [lightBlue, blue];
const List<Color> chart2Colors = [lightBlue, orange];
const double chart1_MaxY = 20;
const double chart2_MaxY = 20;

double chartTopPadding(BuildContext context) {
  return MediaQuery.of(context).size.height / 60;
}

double chartLeftPadding(BuildContext context) {
  return MediaQuery.of(context).size.width / 6.22;
}

double chartIconSizedBox(BuildContext context) {
  return MediaQuery.of(context).size.width / 21.3;
}

double chartLeftMargin(BuildContext context) {
  return MediaQuery.of(context).size.width / 42;
}
