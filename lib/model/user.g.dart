// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    ieeeId: json['ieeeId'] as String,
    joinDate: json['joinDate'] == null
        ? null
        : DateTime.parse(json['joinDate'] as String),
    membershipActive: json['membershipActive'] as bool,
    personalEmail: json['personalEmail'] as String,
    phoneNumber: json['phoneNumber'] as String,
    level: json['level'] as int,
    filiere: json['filiere'] as String,
    gender: _$enumDecodeNullable(_$GenderEnumMap, json['gender']),
    fbLink: json['fbLink'] as String,
    pictureUrl: json['pictureUrl'] == null
        ? null
        : Uri.parse(json['pictureUrl'] as String),
    university: json['university'] as String,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
  )
    ..id = json['id'] as String
    ..chapters = (json['chapters'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'ieeeId': instance.ieeeId,
      'id': instance.id,
      'joinDate': instance.joinDate?.toIso8601String(),
      'membershipActive': instance.membershipActive,
      'personalEmail': instance.personalEmail,
      'phoneNumber': instance.phoneNumber,
      'level': instance.level,
      'filiere': instance.filiere,
      'gender': _$GenderEnumMap[instance.gender],
      'fbLink': instance.fbLink,
      'pictureUrl': instance.pictureUrl?.toString(),
      'university': instance.university,
      'birthDate': instance.birthDate?.toIso8601String(),
      'chapters': instance.chapters,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GenderEnumMap = {
  Gender.male: 0,
  Gender.female: 1,
};
