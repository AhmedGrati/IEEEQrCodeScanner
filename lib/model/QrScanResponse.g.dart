// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QrScanResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrScanResponse _$QrScanResponseFromJson(Map<String, dynamic> json) {
  return QrScanResponse(
    id: json['id'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    memberId: json['memberId'] as String,
    partnerId: json['partnerId'] as int,
    hasIEEEAcount: json['hasIEEEAcount'] as bool,
    expiredAccount: json['expiredAccount'] as bool,
  );
}

Map<String, dynamic> _$QrScanResponseToJson(QrScanResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'memberId': instance.memberId,
      'partnerId': instance.partnerId,
      'hasIEEEAcount': instance.hasIEEEAcount,
      'expiredAccount': instance.expiredAccount,
    };
