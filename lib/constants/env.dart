import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

/* BOTTOM BAR */
const IconData bottomBarMainMenuIcon = Icons.home;
const IconData bottomBarApplicationIcon = CupertinoIcons.app_badge;
const IconData bottomBarBlockedActivitiesIcon = CupertinoIcons.slash_circle;
const IconData bottomBarActivitiesIcon = CupertinoIcons.list_bullet;
const Color bottomBarActiveColor = lightBlue;
const Color bottomBarInActiveColor = blue;
const Color bottomBarBackgroundColor = darkBlue;
const NavBarStyle bottomBarNavBarStyle = NavBarStyle.style13;

const IconData mainMenuFiltersIcon = Icons.filter_list;
const IconData mainMenuStatisticsIcon = Icons.query_stats;
const IconData mainMenuSettingsIcon = Icons.settings;
const IconData generalSettingsIcon = Icons.app_settings_alt_outlined;
const IconData networkSettingsIcon = Icons.perm_data_setting_sharp;
const IconData backupSettingsIcon = Icons.settings_backup_restore;
const IconData advancedSettingsIcon = Icons.admin_panel_settings;
const IconData batterySettingsIcon = Icons.power_settings_new_sharp;

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
