// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return Partner(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    active: json['active'] as bool,
    secretCode: json['secretCode'] as String,
  );
}

Map<String, dynamic> _$PartnerToJson(Partner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'secretCode': instance.secretCode,
      'active': instance.active,
    };
