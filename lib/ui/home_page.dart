import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/ui/main_menu/main_menu.dart';
import 'package:graduation_app/ui/applications/applications.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities.dart';
import 'package:graduation_app/ui/activities/activities.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_app/models/app2.dart';
import 'package:graduation_app/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      const MainMenu(),
      const Applications(),
      const BlockedActivities(),
      const Activities()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(bottomBarMainMenuIcon),
        title: ('hp1'.tr()),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(bottomBarApplicationIcon),
        title: ('hp2'.tr()),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(bottomBarBlockedActivitiesIcon),
        title: ('hp3'.tr()),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(bottomBarActivitiesIcon),
        title: ('hp4'.tr()),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
    ];
  }

  void checkApps() async {
    final box = Boxes.getApp2s();

    List apps =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);

    List<App2> app2s = Boxes.getApp2s().values.toList().cast<App2>();

    int flag;
    for (int i = 0; i < app2s.length; ++i) {
      flag = 0;
      for (int j = 0; j < apps.length; ++j) {
        if (app2s[i].appName == apps[j].appName) {
          flag = 1;
          if (app2s[i].version != apps[j].versionName) {
            app2s[i].version = apps[j].versionName;
            app2s[i].save();
          }
          break;
        }
      }
      if (flag == 0) {
        app2s[i].delete();
      }
    }

    for (int i = 0; i < apps.length; ++i) {
      flag = 0;
      for (int j = 0; j < app2s.length; ++j) {
        if (apps[i].appName == app2s[j].appName) {
          flag = 1;
          break;
        }
      }
      if (flag == 0) {
        final App2 app2 = App2()
          ..appName = apps[i].appName
          ..packageName = apps[i].packageName
          ..version = apps[i].versionName
          ..allowWifi = true
          ..allowMobileNetwork = true
          ..isInWhitelist = false
          ..notificationMode = false
          ..totalActivities_7days = 0
          ..icon = apps[i].icon;

        box.add(app2);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkApps();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: bottomBarBackgroundColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          bottomBarNavBarStyle, // Choose the nav bar style with this property.
    );
  }
}
