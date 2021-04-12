// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) {
  return SongModel(
    json['id'] as int,
    json['number'] as int,
    SongContent.fromJson(json['tamil'] as Map<String, dynamic>),
    SongContent.fromJson(json['tanglish'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'tamil': instance.tamil,
      'tanglish': instance.tanglish,
    };
