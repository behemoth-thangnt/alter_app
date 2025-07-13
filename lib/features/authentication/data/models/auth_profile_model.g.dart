// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTeacherModel _$AuthTeacherModelFromJson(Map<String, dynamic> json) =>
    AuthTeacherModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$AuthTeacherModelToJson(AuthTeacherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'imageUrl': instance.imageUrl,
    };

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
      teacherModel: json['teacher'] == null
          ? null
          : AuthTeacherModel.fromJson(json['teacher'] as Map<String, dynamic>),
      userModel: json['user'] == null
          ? null
          : AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthProfileModelToJson(AuthProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'teacher': instance.teacherModel,
      'user': instance.userModel,
    };
