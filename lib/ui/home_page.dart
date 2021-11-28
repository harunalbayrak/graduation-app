import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/ui/main_menu/main_menu.dart';
import 'package:graduation_app/ui/applications/applications.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities.dart';
import 'package:graduation_app/ui/activities/activities.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
        title: ("Main Menu"),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(bottomBarApplicationIcon),
        title: ("Applications"),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(bottomBarBlockedActivitiesIcon),
        title: ("Blocked Activities"),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(bottomBarActivitiesIcon),
        title: ("Activities"),
        activeColorPrimary: bottomBarActiveColor,
        inactiveColorPrimary: bottomBarInActiveColor,
      ),
    ];
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
