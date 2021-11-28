import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/constants/themes.dart';
import 'package:graduation_app/constants/box_decorations.dart';
import 'package:graduation_app/constants/text_styles.dart';
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

/* MAIN */
ThemeData mainMenuMaterialAppTheme = denemeTheme;

/* MAIN MENU */
const IconData mainMenuFiltersIcon = Icons.filter_list;
const IconData mainMenuStatisticsIcon = Icons.query_stats;
const IconData mainMenuSettingsIcon = Icons.settings;
const double mainMenuText1Size = 40;
const double mainMenuText2Size = mainMenuText1Size / 2;
double mainMenuSpaceSize1(BuildContext context) {
  return MediaQuery.of(context).size.height / 40;
}

double mainMenuSpaceSize2(BuildContext context) {
  return mainMenuSpaceSize1(context) / 2;
}

/* APPLICATIONS */
const double applicationsPaddingLW = 6.0;
const double applicationsPaddingTB = 1.0;
const int applicationsIconDuration = 350;
const IconData applicationsDropdownIcon = Icons.arrow_drop_down;
const IconData applicationsWifiIcon = Icons.wifi;
const IconData applicationsCellDataIcon = Icons.network_cell_sharp;
const IconData applicationsExtendedIcon1 = Icons.assistant_direction;
const IconData applicationsExtendedIcon2 = Icons.badge_sharp;
const Color applicationsTextIconColor = gray;
const Decoration applicationsDecoration = classicBlackGray;

/* BLOCKED ACTIVITIES */
const double blockedActivitiesPadding = 12.0;
const Decoration blockedActivitiesDecoration = classicBlackGray;
const IconData blockedActivitiesRemoveIcon = Icons.highlight_remove;
const Color blockedActivitiesIconColor = gray;
const TextStyle blockedActivitiesTextStyle = textStyle2;

/* BLOCKED ACTIVITIES 2 */
const IconData blockedActivities2Icon1 = Icons.done;
const IconData blockedActivities2Icon2 = Icons.copy_all;

/* ACTIVITIES */
const double activitiesPadding = 12.0;
const Decoration activitiesDecoration = classicBlackGray;
const IconData activitiesBlockIcon = Icons.block;
const Color activitiesIconColor = orange;
const TextStyle activitiesTextStyle = textStyle2;

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
