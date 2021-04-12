import 'package:json_annotation/json_annotation.dart';

import 'song_model.dart';
part 'song_list.g.dart';

@JsonSerializable()
class SongList {
  List<SongModel> songs = [];

  SongList(this.songs);

  factory SongList.fromJson(List<dynamic> parsedJson) =>
      _$SongListFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$SongListToJson(this);
}
