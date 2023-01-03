// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordDTO _$WordDTOFromJson(Map<String, dynamic> json) {

      print(json['uid']);
      print(json['wordsId']);
      print((json['wordsId'] as int?).toString());

  return WordDTO(
      json['uid'] as int?,
      json['author'] as String?,
      json['content'] as String?,
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      json['wordsId'] as int?,
    );
}

Map<String, dynamic> _$WordDTOToJson(WordDTO instance) => <String, dynamic>{
      'uid': instance.uid,
      'author': instance.author,
      'content': instance.content,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'wordsId': instance.wordsId,
    };
