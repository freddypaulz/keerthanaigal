import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes.dart';
import 'theme/colors.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.firstTimeVisit}) : super(key: key);
  final bool? firstTimeVisit;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Keerthanaigal',
      theme: ThemeData(
        primarySwatch: KThemeData.colorLight,
        accentColor: KThemeData.colorLightAccent,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: KThemeData.colorDark,
        accentColor: KThemeData.colorDarkAccent,
        scaffoldBackgroundColor: KThemeData.colorDark.shade500,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white70),
        ),
      ),
      initialRoute:
          firstTimeVisit == true ? Routes.onboardingPage : Routes.homePage,
      onGenerateRoute: Routes.generateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
