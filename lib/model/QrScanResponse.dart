import 'gender.dart';
import 'package:json_annotation/json_annotation.dart';
part 'QrScanResponse.g.dart';

@JsonSerializable()
class QrScanResponse {
  int id;
  DateTime date;
  String memberId;
  String partnerId;
  bool hasIEEEAcount;
  bool expiredAccout;

  QrScanResponse({
    this.id,
    this.date,
    this.memberId,
    this.partnerId,
    this.hasIEEEAcount,
    this.expiredAccout
  });

  factory QrScanResponse.fromJson(Map<String, dynamic> item) => _$QrScanResponseFromJson(item);

  Map<String,dynamic> toJson() => _$QrScanResponseToJson(this);

}