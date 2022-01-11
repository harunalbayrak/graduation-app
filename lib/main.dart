import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/models/app2.dart';
import 'package:graduation_app/models/filter.dart';
import 'package:graduation_app/models/statistic.dart';
import 'package:graduation_app/models/activity.dart';
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
import 'package:graduation_app/boxes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:graduation_app/utils/channel_utils.dart';
import 'dart:async';
import 'dart:collection';

int? initScreen;
bool isStopped = false; //global

void initalizePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  await prefs.setString("vpn4", "10.1.10.1");
}

void initializeDatabase() async {
  final boxApp2s = Boxes.getApp2s();
  final boxFilters = Boxes.getFilters();
  final boxStatistics = Boxes.getStatistics();

  List apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);

  for (int i = 0; i < apps.length; i++) {
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

    boxApp2s.add(app2);
  }

  boxFilters.add(filter0);
  boxFilters.add(filter1);
  boxFilters.add(filter2);
  boxFilters.add(filter3);

  boxStatistics.put('totalAndBlocked', Statistic());
}

Activity? getActivity(Box<Activity> box, String host, String ip) {
  List<Activity> app = box.values
      .toList()
      .where((c) => c.host == host && c.ip == ip)
      .toList()
      .cast<Activity>();

  if (app.isEmpty) {
    return null;
  }

  return app.first;
}

sec5Timer() {
  final boxActivities = Boxes.getActivities();

  Timer.periodic(Duration(seconds: 5), (timer) async {
    if (isStopped) {
      timer.cancel();
    }
    List<Object?> values = await invokeGetFromQueue();
    values.forEach((value) {
      String str = value.toString();
      str = str.replaceAll('{', '').replaceAll('}', '');
      List<String> listStr = str.split(':');

      if (listStr.length >= 2) {
        String host = listStr[0];
        String ip = listStr[1];

        Activity? activity = getActivity(boxActivities, host, ip);

        if (activity == null) {
          final Activity act = Activity()
            ..application = "none"
            ..host = host
            ..ip = ip
            ..isBlocked = false
            ..times = List.of([DateTime.now()])
            ..total_1day = 1
            ..total_7days = 1
            ..appIcon = null;
          if (boxActivities.length < 400) {
            boxActivities.add(act);
          }
        } else {
          List<DateTime> dates = activity.times;
          dates.add(DateTime.now());

          final Activity act = Activity()
            ..application = "none"
            ..host = host
            ..ip = ip
            ..isBlocked = activity.isBlocked
            ..times = dates
            ..total_1day = activity.total_1day + 1
            ..total_7days = activity.total_7days + 1
            ..appIcon = null;

          boxActivities.delete(activity.key);
          boxActivities.add(act);
        }
      }
    });
    await invokeClearQueue();
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  initalizePreferences();

  await Hive.initFlutter();
  Hive.registerAdapter(App2Adapter());
  Hive.registerAdapter(FilterAdapter());
  Hive.registerAdapter(StatisticAdapter());
  Hive.registerAdapter(ActivityAdapter());
  await Hive.openBox<App2>('app2s');
  await Hive.openBox<Filter>('filters');
  await Hive.openBox<Statistic>('statistics');
  await Hive.openBox<Activity>('activities');

  sec5Timer();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

@override
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          '/filters2': (context) => Filters2(filter: filter0),
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
