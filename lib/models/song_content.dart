import 'package:json_annotation/json_annotation.dart';
part 'song_content.g.dart';

@JsonSerializable()
class SongContent {
  String title;
  List<List<String>> content;

  SongContent(this.title, this.content);

  factory SongContent.fromJson(Map<String, dynamic> parsedJson) =>
      _$SongContentFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$SongContentToJson(this);
}
