import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:keerthanaigal/utilities/fontSizePreference.dart';
import 'package:keerthanaigal/utilities/songLanguagePreference.dart';
import 'package:keerthanaigal/utilities/themePreference.dart';

class UiState extends ChangeNotifier {
  UiState();

  double fontSize = 18;
  double tempFontSize = 18;
  int language = 0;
  int theme = 2;

  changeTheme(int value) async {
    theme = value;
    await ThemePreference().setTheme(value);
    notifyListeners();
  }

  getUserTheme() async {
    int? userTheme = await ThemePreference().getTheme();
    if (userTheme == null) {
      await ThemePreference().setTheme(2);
      this.theme = 2;
    } else {
      this.theme = userTheme;
    }
  }

  changeFontSize(double value) async {
    fontSize = value;
    await FontSizePreference().setFontSize(value);
    notifyListeners();
  }

  getUserFontSize() async {
    double? userFontSize = await FontSizePreference().getFontSize();
    if (userFontSize == null) {
      await FontSizePreference().setFontSize(18);
      this.fontSize = 18;
    } else {
      this.fontSize = userFontSize;
    }
  }

  getFontSize(double width) async {
    await getUserFontSize();
    if (width <= 479) {
      fontSize = this.fontSize;
    } else if (width <= 767) {
      fontSize = this.fontSize * 1.25;
    } else if (width <= 991) {
      fontSize = this.fontSize * 1.5;
    }
  }

  changeSongLanguage(int value) async {
    this.language = value;

    await SongLanguagePreference().setSongLanguage(value);
    notifyListeners();
  }

  getUserSongLanguage() async {
    int? userSongLanguage = await SongLanguagePreference().getSongLanguage();

    if (userSongLanguage == null) {
      await SongLanguagePreference().setSongLanguage(0);
      this.language = 0;
    } else {
      this.language = userSongLanguage;
    }
    notifyListeners();
  }

  changeTempFontSize(double value) {
    tempFontSize = value;
    notifyListeners();
  }

  getTempFontSize() {
    return tempFontSize;
  }
}

// ignore: non_constant_identifier_names
final UiProvider = ChangeNotifierProvider<UiState>((ref) {
  return UiState();
});
