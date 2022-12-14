import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlewords/word_dto.dart';

part 'words_dto.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable() // Va permettre de générer des méthodes from et toJson
class WordsDTO {
  // Constructeur
  WordsDTO(this.data);

  // Attributs
  final List<WordDTO>? data;

  Map<String, dynamic> toJson() => _$WordsDTOToJson(this);

  factory WordsDTO.fromJson(Map<String, dynamic> json) => _$WordsDTOFromJson(json);
}