import 'package:flutter/material.dart';
import 'package:keerthanaigal/pages/main/index.dart';
import 'pages/home/index.dart';
import 'pages/onboarding/index.dart';
import 'pages/search/index.dart';
import 'pages/songView/index.dart';

class Routes {
  Routes._();

  static const String mainPage = '/';
  static const String homePage = '/home';
  static const String searchPage = '/search';
  static const String onboardingPage = '/onboarding';
  static const String songViewPage = '/songView';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainPage(),
        );
      case Routes.mainPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SearchPage(),
        );
      case Routes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
        );
      case Routes.onboardingPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => OnBoarding(),
        );
      case Routes.songViewPage:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => SongViewPage(),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}

class RouteException implements Exception {
  const RouteException(this.message);
  final String message;
}
