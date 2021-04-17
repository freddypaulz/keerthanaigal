import 'package:shared_preferences/shared_preferences.dart';

class SongLanguagePreference {
  Future<int?> getSongLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    int? songLanguage =
        pref.getInt('songLanguage') == null ? 0 : pref.getInt('songLanguage');

    return songLanguage;
  }

  setSongLanguage(int language) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('songLanguage', language);
  }
}
