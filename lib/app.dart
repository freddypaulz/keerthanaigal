import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keerthanaigal/pages/main/index.dart';
import 'package:keerthanaigal/pages/onboarding/index.dart';
import 'package:keerthanaigal/providers/ui_provider.dart';

import 'routes.dart';
import 'theme/colors.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {
  MyApp({Key? key, this.firstTimeVisit}) : super(key: key);
  final bool? firstTimeVisit;
  @override
  Widget build(BuildContext context, watch) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    var uiProviderData = watch(UiProvider);
    uiProviderData.getUserTheme();
    return MaterialApp(
      title: 'Keerthanaigal',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: KThemeData.colorLight,
        accentColor: KThemeData.colorLightAccent,
        scaffoldBackgroundColor: KThemeData.colorLight.shade500,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
          bodyText2: TextStyle(color: Colors.black38),
        ),
        fontFamily: 'SourceSansPro',
      ),
      darkTheme: ThemeData(
        primarySwatch: KThemeData.colorDark,
        accentColor: KThemeData.colorDarkAccent,
        scaffoldBackgroundColor: KThemeData.colorDark.shade500,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white70),
          bodyText2: TextStyle(color: Colors.white54),
        ),
        fontFamily: 'SourceSansPro',
      ),
      themeMode: uiProviderData.theme == 2
          ? ThemeMode.system
          : uiProviderData.theme == 1
              ? ThemeMode.dark
              : ThemeMode.light,
      home: firstTimeVisit == true ? OnBoarding() : MainPage(),
      onGenerateRoute: Routes.generateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
