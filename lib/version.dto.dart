import 'package:freezed_annotation/freezed_annotation.dart';

part 'version.dto.g.dart';

// flutter pub run build_runner buld --delete-conflicting-ouputs
@JsonSerializable()
class VersionDTO{
  VersionDTO(this.version);
  final String version;

  static VersionDTO fromJson(json) => _$VersionDTOFromJson(json);
}