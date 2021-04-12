// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongList _$SongListFromJson(List<dynamic> json) {
  return SongList(
    (json).map((e) => SongModel.fromJson(e as Map<String, dynamic>)).toList(),
  );
}

Map<String, dynamic> _$SongListToJson(SongList instance) => <String, dynamic>{
      'songs': instance.songs,
    };
