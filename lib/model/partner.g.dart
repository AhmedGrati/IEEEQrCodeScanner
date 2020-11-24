// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return Partner(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    active: json['active'] as bool,
    code: json['code'] as String,
    rate: (json['rate'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PartnerToJson(Partner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'code': instance.code,
      'active': instance.active,
      'rate': instance.rate,
    };
