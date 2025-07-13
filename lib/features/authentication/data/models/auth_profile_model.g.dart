// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) =>
    AuthUserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birthDate'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AuthUserModelToJson(AuthUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

AuthProfileModel _$AuthProfileModelFromJson(Map<String, dynamic> json) =>
    AuthProfileModel(
      id: json['id'] as String,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userModel: AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthProfileModelToJson(AuthProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'user': instance.userModel,
    };
