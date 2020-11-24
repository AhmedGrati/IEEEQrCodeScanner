

import 'package:json_annotation/json_annotation.dart';
part 'partner.g.dart';
@JsonSerializable()
class Partner {
  int id;
  String name;
  String email;
  String code;
  bool active;
  double rate;
  Partner({
    this.id,
    this.name,
    this.email,
    this.active,
    this.code,
    this.rate
  });

  factory Partner.fromJson(Map<String, dynamic> item) => _$PartnerFromJson(item);

  Map<String,dynamic> toJson() => _$PartnerToJson(this);

}