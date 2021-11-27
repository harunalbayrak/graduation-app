import 'package:flutter/material.dart';
import 'package:graduation_app/ui/filters/filters.dart';
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
        '/': (context) => HomePage(),
        '/main_menu': (context) => MainMenu(),
        '/applications': (context) => Applications(),
        '/blocked_activities': (context) => BlockedActivities(),
        '/blocked_activities_2': (context) => BlockedActivities2(),
        '/activities': (context) => Activities(),
        '/activities_2': (context) => Activities2(),
        '/filters': (context) => Filters(),
      },
      theme: denemeTheme,
    );
  }
}
