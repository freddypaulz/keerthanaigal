import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:keerthanaigal/utilities/fontSize.dart';

class UiState extends ChangeNotifier {
  UiState();

  double fontSize = 18;
  double tempFontSize = 18;

  changeFontSize(double value) async {
    fontSize = value;
    await FontSize().setFontSize(value);
    notifyListeners();
  }

  getUserFontSize() async {
    double? userFontSize = await FontSize().getFontSize();
    if (userFontSize == null) {
      await FontSize().setFontSize(18);
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
