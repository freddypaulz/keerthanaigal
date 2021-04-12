import 'package:json_annotation/json_annotation.dart';

import 'song_content.dart';
part 'song_model.g.dart';

@JsonSerializable()
class SongModel {
  int id;
  int number;
  SongContent tamil;
  SongContent tanglish;

  SongModel(this.id, this.number, this.tamil, this.tanglish);

  factory SongModel.fromJson(Map<String, dynamic> parsedJson) =>
      _$SongModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}
