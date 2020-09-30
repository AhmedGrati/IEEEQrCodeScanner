import 'package:json_annotation/json_annotation.dart';

part 'secret.g.dart';

@JsonSerializable()
class Secret {
  String secretCode;

  Secret({this.secretCode});

  factory Secret.fromJson(Map<String, dynamic> item) => _$SecretFromJson(item);

  Map<String,dynamic> toJson() => _$SecretToJson(this);
}