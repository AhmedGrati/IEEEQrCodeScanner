// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanBody _$ScanBodyFromJson(Map<String, dynamic> json) {
  return ScanBody(
    secretCode: json['code'] as String,
    memberIeeeId: json['id'] as String,
  );
}

Map<String, dynamic> _$ScanBodyToJson(ScanBody instance) => <String, dynamic>{
      'code': instance.memberIeeeId,
      'id': instance.secretCode,
    };
