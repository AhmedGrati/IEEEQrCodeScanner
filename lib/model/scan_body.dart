import 'package:json_annotation/json_annotation.dart';
part 'scan_body.g.dart';

@JsonSerializable()
class ScanBody {
  String memberIeeeId;
  String secretCode;

  ScanBody({
    this.secretCode,
    this.memberIeeeId
  });

  factory ScanBody.fromJson(Map<String, dynamic> item) => _$ScanBodyFromJson(item);

  Map<String,dynamic> toJson() => _$ScanBodyToJson(this);
}