import 'package:flutter/material.dart';
import 'package:graduation_app/ui/filters/filters.dart';
import 'package:graduation_app/ui/statistics/statistics.dart';
import 'package:graduation_app/ui/settings/settings.dart';
import 'package:graduation_app/ui/settings/general_settings.dart';
import 'package:graduation_app/ui/settings/network_settings.dart';
import 'package:graduation_app/ui/settings/backup_settings.dart';
import 'package:graduation_app/ui/settings/advanced_settings.dart';
import 'package:graduation_app/ui/settings/battery_settings.dart';
import 'package:graduation_app/ui/home_page.dart';
import 'package:graduation_app/ui/main_menu/main_menu.dart';
import 'package:graduation_app/ui/applications/applications.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities.dart';
import 'package:graduation_app/ui/blocked_activities/blocked_activities_2.dart';
import 'package:graduation_app/ui/activities/activities.dart';
import 'package:graduation_app/ui/activities/activities_2.dart';
import 'package:graduation_app/constants/themes.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/main_menu': (context) => const MainMenu(),
        '/applications': (context) => const Applications(),
        '/blocked_activities': (context) => const BlockedActivities(),
        '/blocked_activities2': (context) => const BlockedActivities2(),
        '/activities': (context) => const Activities(),
        '/activities2': (context) => const Activities2(),
        '/filters': (context) => const Filters(),
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
  }
}
