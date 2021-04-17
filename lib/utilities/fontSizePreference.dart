import 'package:shared_preferences/shared_preferences.dart';

class FontSizePreference {
  Future<double?> getFontSize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    double? fontSize =
        pref.getDouble('fontSize') == null ? 18 : pref.getDouble('fontSize');

    return fontSize;
  }

  setFontSize(double size) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble('fontSize', size);
  }
}
