// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanBody _$ScanBodyFromJson(Map<String, dynamic> json) {
  return ScanBody(
    secretCode: json['secretCode'] as String,
    memberIeeeId: json['memberIEEEId'] as String,
  );
}

Map<String, dynamic> _$ScanBodyToJson(ScanBody instance) => <String, dynamic>{
      'memberIEEEId': instance.memberIeeeId,
      'secretCode': instance.secretCode,
    };
