// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Secret _$SecretFromJson(Map<String, dynamic> json) {
  return Secret(
    secretCode: json['secretCode'] as String,
  );
}

Map<String, dynamic> _$SecretToJson(Secret instance) => <String, dynamic>{
      'secretCode': instance.secretCode,
    };
