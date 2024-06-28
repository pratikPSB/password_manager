// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaultModel _$VaultModelFromJson(Map<String, dynamic> json) => VaultModel(
      name: json['name'] as String?,
      vaultColor: json['vaultColor'] as String?,
      iconPath: json['iconPath'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$VaultModelToJson(VaultModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'vaultColor': instance.vaultColor,
      'iconPath': instance.iconPath,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
