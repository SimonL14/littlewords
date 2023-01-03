// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordsDTO _$WordsDTOFromJson(Map<String, dynamic> json) => WordsDTO(
      (json['data'] as List<dynamic>?)
          ?.map((e) => WordDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordsDTOToJson(WordsDTO instance) => <String, dynamic>{
      'data': instance.data,
    };
