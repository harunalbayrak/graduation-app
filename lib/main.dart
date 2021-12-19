import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:graduation_app/db/app_db.dart';
import 'package:graduation_app/models/app.dart';
import 'package:graduation_app/ui/filters/filters.dart';
import 'package:graduation_app/ui/filters/filters_2.dart';
import 'package:graduation_app/ui/home_page.dart';
import 'package:graduation_app/ui/statistics/statistics.dart';
import 'package:graduation_app/ui/settings/settings.dart';
import 'package:graduation_app/ui/settings/general_settings.dart';
import 'package:graduation_app/ui/settings/network_settings.dart';
import 'package:graduation_app/ui/settings/backup_settings.dart';
import 'package:graduation_app/ui/settings/advanced_settings.dart';
import 'package:graduation_app/ui/settings/battery_settings.dart';
import 'package:graduation_app/ui/introduction_page.dart';
import 'package:graduation_app/ui/main_menu/main_menu.dart';
import 'package:graduation_app/ui/applications/applications.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities_2.dart';
import 'package:graduation_app/ui/activities/activities.dart';
import 'package:graduation_app/ui/activities/activities_2.dart';
import 'package:graduation_app/constants/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

void initalizePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
}

void initializeDatabase() async {
  List apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);

  for (int i = 0; i < apps.length; i++) {
    App app = App(
      appName: apps[i].appName,
      packageName: apps[i].packageName,
      version: apps[i].versionName,
      allowWifi: true,
      allowMobileNetwork: true,
      isInWhitelist: false,
      notificationMode: false,
      totalActivities_7days: 0,
      icon: apps[i].icon,
    );
    await AppDatabase.instance.create(app);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  initalizePreferences();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

@override
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (initScreen == 0 || initScreen == null) {
      initializeDatabase();
    }
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute:
            initScreen == 0 || initScreen == null ? '/' : '/home_page',
        routes: {
          '/': (context) => const IntroductionPage(),
          '/home_page': (context) => const HomePage(),
          '/main_menu': (context) => const MainMenu(),
          '/applications': (context) => const Applications(),
          '/blocked_activities': (context) => const BlockedActivities(),
          '/blocked_activities2': (context) => const BlockedActivities2(),
          '/activities': (context) => const Activities(),
          '/activities2': (context) => const Activities2(),
          '/filters': (context) => const Filters(),
          '/filters2': (context) => const Filters2(),
          '/statistics': (context) => const Statistics(),
          '/settings': (context) => const Settings(),
          '/general_settings': (context) => const GeneralSettings(),
          '/network_settings': (context) => const NetworkSettings(),
          '/backup_settings': (context) => const BackupSettings(),
          '/advanced_settings': (context) => const AdvancedSettings(),
          '/battery_settings': (context) => const BatterySettings(),
        },
        theme: denemeTheme,
      );
    });
  }
}
