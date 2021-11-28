import 'package:flutter/material.dart';

const double paddingMin = 8.0;
const double paddingOverall = 12.0;

const double borderRadiusMin = 4.0;

const double chartAspectRatio = 1.5;
const double chartLeftInterval = 1;
const double chartLeftReservedSize = 28;

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
