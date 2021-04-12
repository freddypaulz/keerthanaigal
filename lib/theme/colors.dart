import 'package:flutter/material.dart';

class KThemeData {
  KThemeData._();
  static const MaterialColor colorLight = MaterialColor(
    _light,
    <int, Color>{
      50: Color.fromRGBO(255, 255, 255, .1),
      100: Color.fromRGBO(255, 255, 255, .2),
      200: Color.fromRGBO(255, 255, 255, .3),
      300: Color.fromRGBO(255, 255, 255, .4),
      400: Color.fromRGBO(255, 255, 255, .5),
      500: Color(_light),
      600: Color.fromRGBO(255, 255, 255, .7),
      700: Color.fromRGBO(255, 255, 255, .8),
      800: Color.fromRGBO(255, 255, 255, .9),
      900: Color.fromRGBO(255, 255, 255, 1),
    },
  );

  static const int _light = 0xFFFFFFFF;

  static const MaterialColor colorLightAccent = MaterialColor(
    _lightAccent,
    <int, Color>{
      50: Color.fromRGBO(79, 10, 140, .1),
      100: Color.fromRGBO(79, 10, 140, .2),
      200: Color.fromRGBO(79, 10, 140, .3),
      300: Color.fromRGBO(79, 10, 140, .4),
      400: Color.fromRGBO(79, 10, 140, .5),
      500: Color(_lightAccent),
      600: Color.fromRGBO(79, 10, 140, .7),
      700: Color.fromRGBO(79, 10, 140, .8),
      800: Color.fromRGBO(79, 10, 140, .9),
      900: Color.fromRGBO(79, 10, 140, 1),
    },
  );

  static const int _lightAccent = 0xFF4F0A8C;

  static const MaterialColor colorDark = MaterialColor(
    _dark,
    <int, Color>{
      50: Color.fromRGBO(33, 35, 40, .1),
      100: Color.fromRGBO(33, 35, 40, .2),
      200: Color.fromRGBO(33, 35, 40, .3),
      300: Color.fromRGBO(33, 35, 40, .4),
      400: Color.fromRGBO(33, 35, 40, .5),
      500: Color(_dark),
      600: Color.fromRGBO(33, 35, 40, .7),
      700: Color.fromRGBO(33, 35, 40, .8),
      800: Color.fromRGBO(33, 35, 40, .9),
      900: Color.fromRGBO(33, 35, 40, 1),
    },
  );

  static const int _dark = 0xFF212328;

  static const MaterialColor colorDarkAccent = MaterialColor(
    _darkAccent,
    <int, Color>{
      50: Color.fromRGBO(255, 89, 81, .1),
      100: Color.fromRGBO(255, 89, 81, .2),
      200: Color.fromRGBO(255, 89, 81, .3),
      300: Color.fromRGBO(255, 89, 81, .4),
      400: Color.fromRGBO(255, 89, 81, .5),
      500: Color(_darkAccent),
      600: Color.fromRGBO(255, 89, 81, .7),
      700: Color.fromRGBO(255, 89, 81, .8),
      800: Color.fromRGBO(255, 89, 81, .9),
      900: Color.fromRGBO(255, 89, 81, 1),
    },
  );

  static const int _darkAccent = 0xFFFF5951;
}
