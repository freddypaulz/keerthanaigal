import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keerthanaigal/models/song_content.dart';
import 'package:keerthanaigal/models/song_list.dart';
import 'package:keerthanaigal/models/song_model.dart';
import 'package:keerthanaigal/utilities/favoriteSongPreference.dart';

class SongState extends ChangeNotifier {
  SongState(this.songList, this.songViewId) {
    getSongs();
    getFavoriteList();
  }

  SongList songList;
  List<String> favoriteList = [];
  int songViewId;

  getSongs() async {
    List<dynamic> parsedJson = await loadJson();
    this.songList = SongList.fromJson(parsedJson);
    notifyListeners();
  }

  Future<List<dynamic>> loadJson() async {
    String data = await rootBundle.loadString('assets/songs.json');
    List<dynamic> jsonResult = json.decode(data);
    return jsonResult;
  }

  setSongId(int id) async {
    songViewId = id;
  }

  getFavoriteList() async {
    this.favoriteList =
        await FavoriteSongPreference().getFavoriteSongList() ?? [];
    notifyListeners();
  }

  setFavoriteList(int songNumber) async {
    favoriteList.add(songNumber.toString());
    await FavoriteSongPreference().setFavoriteSongList(favoriteList);
    notifyListeners();
  }

  removeFavorite(int songNumber) async {
    favoriteList.remove(songNumber.toString());
    await FavoriteSongPreference().setFavoriteSongList(favoriteList);
    notifyListeners();
  }
}

// ignore: non_constant_identifier_names
final SongsProvider = ChangeNotifierProvider<SongState>((ref) {
  SongList songList = new SongList(
    [
      new SongModel(
        1,
        1,
        new SongContent(
          '',
          [],
        ),
        new SongContent(
          '',
          [],
        ),
      ),
    ],
  );

  return SongState(songList, 1);
});
