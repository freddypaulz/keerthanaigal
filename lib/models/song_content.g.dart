// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongContent _$SongContentFromJson(Map<String, dynamic> json) {
  return SongContent(
    json['title'] as String,
    (json['content'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList(),
  );
}

Map<String, dynamic> _$SongContentToJson(SongContent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
