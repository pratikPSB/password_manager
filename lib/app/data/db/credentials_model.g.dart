// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialsModel _$CredentialsModelFromJson(Map<String, dynamic> json) =>
    CredentialsModel(
      vaultId: json['vaultId'] as String?,
      credType: json['credType'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      websites: (json['websites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      notes: json['notes'] as String?,
      nameOnCard: json['nameOnCard'] as String?,
      cardNumber: json['cardNumber'] as String?,
      expiryDate: json['expiryDate'] as String?,
      cvvCode: json['cvvCode'] as String?,
      cardPin: json['cardPin'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CredentialsModelToJson(CredentialsModel instance) =>
    <String, dynamic>{
      'vaultId': instance.vaultId,
      'credType': instance.credType,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'websites': instance.websites,
      'notes': instance.notes,
      'nameOnCard': instance.nameOnCard,
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
      'cvvCode': instance.cvvCode,
      'cardPin': instance.cardPin,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
