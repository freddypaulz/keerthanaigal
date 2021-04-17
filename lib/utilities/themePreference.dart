import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  Future<int?> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int? themePreference =
        pref.getInt('theme') == null ? 2 : pref.getInt('theme');

    return themePreference;
  }

  setTheme(int theme) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('theme', theme);
  }
}
