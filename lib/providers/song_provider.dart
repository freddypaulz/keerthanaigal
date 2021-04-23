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

  int songViewId;
  SongList songList;
  List<String> favoriteList = [];
  List<SongModel> songSearchList = [];
  String searchResultText = '';
  bool isLoading = false;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  getSongs() async {
    setLoader(true);
    List<dynamic> parsedJson = await loadJson();
    this.songList = SongList.fromJson(parsedJson);
    setLoader(false);
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
    // setLoader(true);

    this.favoriteList =
        await FavoriteSongPreference().getFavoriteSongList() ?? [];
    // setLoader(false);
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

  bool songContentSearch(List<List<String>> content, String searchKey) {
    bool found = false;
    // print('hi');

    for (int i = 0; i < content.length; i++) {
      for (int j = 0; j < content[i].length; j++) {
        // print(content[i][j].toLowerCase());
        if (content[i][j].toLowerCase().contains(searchKey.toLowerCase())) {
          // print('found');
          found = true;
          break;
        }
      }
    }
    return found;
  }

  getSongSearchResults(String searchKey) {
    if (searchKey.length > 0) {
      setLoader(true);
      print('loader: true');
      songSearchList = songList.songs.where((element) {
        return element.tanglish.title
                .toLowerCase()
                .contains(searchKey.toLowerCase()) ||
            element.tamil.title.contains(searchKey) ||
            element.number.toString() == searchKey ||
            songContentSearch(element.tanglish.content, searchKey) ||
            songContentSearch(element.tamil.content, searchKey);
      }).toList();
      if (songSearchList.length == 0) searchResultText = 'No song found';
    } else {
      songSearchList = [];
      searchResultText = '';
    }
    setLoader(false);
    print('loader: false');
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
