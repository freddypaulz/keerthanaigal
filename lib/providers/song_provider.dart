import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keerthanaigal/models/song_content.dart';
import 'package:keerthanaigal/models/song_list.dart';
import 'package:keerthanaigal/models/song_model.dart';

class SongState extends ChangeNotifier {
  SongState(this.songList, this.songViewId) {
    getSongs().then((value) {
      this.songList = value;
      notifyListeners();
    });
  }

  SongList songList;
  int songViewId;

  Future<SongList> getSongs() async {
    List<dynamic> parsedJson = await loadJson();
    return SongList.fromJson(parsedJson);
  }

  Future<List<dynamic>> loadJson() async {
    String data = await rootBundle.loadString('assets/songs.json');
    List<dynamic> jsonResult = json.decode(data);
    return jsonResult;
  }

  setSongId(int id) async {
    songViewId = id;
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
