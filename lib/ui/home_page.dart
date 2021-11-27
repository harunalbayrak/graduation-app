import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/ui/main_menu/main_menu.dart';
import 'package:graduation_app/ui/applications/applications.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities.dart';
import 'package:graduation_app/ui/activities/activities.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [MainMenu(), Applications(), BlockedActivities(), Activities()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Main Menu"),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: blue,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.app),
        title: ("Applications"),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: blue,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.slash_circle),
        title: ("Blocked Activities"),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: blue,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.list_bullet),
        title: ("Activities"),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: blue,
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
      backgroundColor: darkBlue, // Default is Colors.white.
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
          NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }
}
