

import 'package:json_annotation/json_annotation.dart';
part 'partner.g.dart';
@JsonSerializable()
class Partner {
  String id;
  String name;
  String email;
  String secretCode;
  bool active;
  Partner({
    this.id,
    this.name,
    this.email,
    this.active,
    this.secretCode
  });

  factory Partner.fromJson(Map<String, dynamic> item) => _$PartnerFromJson(item);

  Map<String,dynamic> toJson() => _$PartnerToJson(this);

}