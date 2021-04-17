import 'package:shared_preferences/shared_preferences.dart';

class FavoriteSongPreference {
  Future<List<String>?> getFavoriteSongList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> favoriteSongs = pref.getStringList('favoriteSongs') ?? [];

    return favoriteSongs;
  }

  setFavoriteSongList(List<String> favoriteList) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setStringList('favoriteSongs', favoriteList);
  }
}
