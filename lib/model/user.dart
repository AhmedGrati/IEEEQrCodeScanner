import 'gender.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String firstName;
  String lastName;
  String ieeeId;
  String id;
  DateTime joinDate;
  bool membershipActive;
  String personalEmail;
  String phoneNumber;

  int level;

  String filiere;

  Gender gender;

  String fbLink;

  Uri pictureUrl;

  String university;

  DateTime birthDate;

  List<String> chapters;

  User({
    this.firstName,
    this.lastName,
    this.ieeeId,
    this.joinDate,
    this.membershipActive,
    this.personalEmail,
    this.phoneNumber,
    this.level,
    this.filiere,
    this.gender,
    this.fbLink,
    this.pictureUrl,
    this.university,
    this.birthDate
  });

  factory User.fromJson(Map<String, dynamic> item) => _$UserFromJson(item);

  Map<String,dynamic> toJson() => _$UserToJson(this);

}