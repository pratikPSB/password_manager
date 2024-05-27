import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'vault_model.g.dart';

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
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  VaultModel({
    this.name,
    this.vaultColor,
    this.iconPath,
    this.createdAt,
    this.updatedAt,
  });

  VaultModel copyWith({
    String? name,
    String? vaultColor,
    String? iconPath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      VaultModel(
        name: name ?? this.name,
        vaultColor: vaultColor ?? this.vaultColor,
        iconPath: iconPath ?? this.iconPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory VaultModel.fromJson(Map<String, dynamic> json) => _$VaultModelFromJson(json);

  Map<String, dynamic> toJson() => _$VaultModelToJson(this);
}
