import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_dto.g.dart';

@JsonSerializable() // Permet de générer des méthodes from et toJson
class WordDTO{
  //Constructeur
  WordDTO(this.uid, this.author, this.content, this.lagitude, this.longitude, this.worldId);

  // Attributs // int? ou String? permet de dire que les attributs peuvent être null
  final int? uid;
  final String? author;
  final String? content;
  final double? lagitude;
  final double? longitude;
  final int? worldId;

  Map<String, dynamic> toJson() => _$WordDTOToJson(this);

  factory WordDTO.fromJson(Map<String, dynamic> json) => _$WordDTOFromJson(json);

  //Permet de créer un WordDTO avec le resultat d'une requete SQLite
  static fromMap(Map<String, dynamic> map) => WordDTO.fromJson(map);
}