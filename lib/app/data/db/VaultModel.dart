import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'VaultModel.g.dart';

@Entity()
@JsonSerializable()
class VaultModel {
  @Id()
  int id = 0;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "vaultColor")
  String? vaultColor;
  @JsonKey(name: "iconPath")
  String? iconPath;

  VaultModel({
    this.name,
    this.vaultColor,
    this.iconPath,
  });

  VaultModel copyWith({
    String? name,
    String? vaultColor,
    String? iconPath,
  }) =>
      VaultModel(
        name: name ?? this.name,
        vaultColor: vaultColor ?? this.vaultColor,
        iconPath: iconPath ?? this.iconPath,
      );

  factory VaultModel.fromJson(Map<String, dynamic> json) => _$VaultModelFromJson(json);

  Map<String, dynamic> toJson() => _$VaultModelToJson(this);
}
