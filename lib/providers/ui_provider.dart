import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:keerthanaigal/utilities/setFontSize.dart';

class UiState extends ChangeNotifier {
  UiState(this.fontSize);

  double fontSize;
  changeFontSize(double value) async {
    fontSize = value;
    await SetFontSize().setFontSize(value);
    notifyListeners();
  }

  getUserFontSize() async {
    double? userFontSize = await SetFontSize().getFontSize();
    if (userFontSize == null) {
      await SetFontSize().setFontSize(18);
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
}

// ignore: non_constant_identifier_names
final UiProvider = ChangeNotifierProvider<UiState>((ref) {
  return UiState(18);
});
