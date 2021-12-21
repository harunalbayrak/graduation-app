import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/themes.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_icons/flutter_icons.dart';

/* GENERAL */
const double paddingMin = 8.0;
const double paddingOverall = 12.0;
const double paddingMax = 20.0;
const double borderRadiusMin = 4.0;
const IconData appBarIconDots = Icons.more_vert;
const IconData appBarIconSort = Icons.sort;
const IconData appBarIconSearch = Icons.search;
const IconData appBarIconSearchCancel = Icons.cancel;
const Color appBarDropdownActiveColor = orange;
BoxDecoration blackGrayDecoration = classicBlackGray;

/* BOTTOM BAR */
const IconData bottomBarMainMenuIcon = Icons.home;
const IconData bottomBarApplicationIcon = CupertinoIcons.app_badge;
const IconData bottomBarBlockedActivitiesIcon = CupertinoIcons.slash_circle;
const IconData bottomBarActivitiesIcon = CupertinoIcons.list_bullet;
const Color bottomBarActiveColor = lightBlue;
const Color bottomBarInActiveColor = blue;
const Color bottomBarBackgroundColor = darkBlue;
const NavBarStyle bottomBarNavBarStyle = NavBarStyle.style13;

/* MAIN */
ThemeData mainMenuMaterialAppTheme = denemeTheme;

/* MAIN MENU */
const mainButtonIcons = [
  MaterialCommunityIcons.star_four_points_outline,
  MaterialCommunityIcons.shield_link_variant,
  MaterialCommunityIcons.rhombus_split,
  MaterialCommunityIcons.octagram,
  MaterialCommunityIcons.octagon,
  MaterialCommunityIcons.hexagram,
  MaterialCommunityIcons.hexagon,
  MaterialCommunityIcons.hexagon_multiple,
  MaterialCommunityIcons.hexagon_slice_6,
  MaterialCommunityIcons.crown,
  MaterialCommunityIcons.chess_queen,
];
const IconData mainMenuFiltersIcon = Icons.filter_list;
const IconData mainMenuStatisticsIcon = Icons.query_stats;
const IconData mainMenuSettingsIcon = Icons.settings;

/* APPLICATIONS */
const int applicationsIconDuration = 350;
const IconData applicationsDropdownIcon = Icons.arrow_drop_down;
const IconData applicationsWifiIcon = Icons.wifi;
const IconData applicationsWifiOffIcon = Icons.wifi_off;
const IconData applicationsCellDataIcon =
    MaterialCommunityIcons.network_strength_4;
const IconData applicationsCellDataOffIcon =
    MaterialCommunityIcons.network_strength_off;
const IconData applicationsExtendedIcon1 = Icons.assistant_direction;
const IconData applicationsExtendedIcon2 = Icons.badge_sharp;
const Color applicationsTextIconColor = gray;

/* BLOCKED ACTIVITIES */
const IconData blockedActivitiesRemoveIcon = Icons.highlight_remove;
const Color blockedActivitiesIconColor = gray;

/* BLOCKED ACTIVITIES 2 */
const IconData blockedActivities2Icon1 = Icons.done;
const IconData blockedActivities2Icon2 = Icons.copy_all;

/* ACTIVITIES */
const IconData activitiesBlockIcon = Icons.block;
const Color activitiesIconColor = orange;
//const TextStyle activitiesTextStyle = textStyle2;

/* FILTERS */
const Color filtersSwitchActiveColor = lightBlue;

/* STATISTICS */
double statisticsHeight = 2.h;
double statisticsBarWidth = 2.w;

/* SETTINGS */
const IconData generalSettingsIcon = Icons.app_settings_alt_outlined;
const IconData networkSettingsIcon = Icons.perm_data_setting_sharp;
const IconData backupSettingsIcon = Icons.settings_backup_restore;
const IconData advancedSettingsIcon = Icons.admin_panel_settings;
const IconData batterySettingsIcon = Icons.power_settings_new_sharp;

/* BAR CHARTS */
const double chartAspectRatio = 1.5;
const double chartLeftInterval = 1;
const double chartLeftReservedSize = 28;
const List<Color> chart1Colors_1 = [lightBlue, orange];
const List<Color> chart1Colors_2 = [lightBlue, blue];
const List<Color> chart2Colors = [lightBlue, orange];
const double barChart1MaxY = 20;
const double barChart2MaxY = 20;
