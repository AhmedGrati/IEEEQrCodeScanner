import 'package:json_annotation/json_annotation.dart';
part 'scan_body.g.dart';

@JsonSerializable()
class ScanBody {
  String memberIEEEId;
  String secretCode;

  ScanBody({
    this.secretCode,
    this.memberIEEEId
  });

  factory ScanBody.fromJson(Map<String, dynamic> item) => _$ScanBodyFromJson(item);

  Map<String,dynamic> toJson() => _$ScanBodyToJson(this);
}