// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) => TeacherModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      active: json['active'] as bool,
      award: json['award'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      slug: json['slug'] as String,
      contactEmail: json['contactEmail'] as String?,
      description: json['description'] as String?,
      basicEntered: json['basicEntered'] as bool,
      canInviteStudents: json['canInviteStudents'] as bool,
      imageUrl: json['imageUrl'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      approvedCourseCount: (json['approvedCourseCount'] as num).toInt(),
      studentCount: (json['studentCount'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'award': instance.award,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'slug': instance.slug,
      'contactEmail': instance.contactEmail,
      'description': instance.description,
      'basicEntered': instance.basicEntered,
      'canInviteStudents': instance.canInviteStudents,
      'imageUrl': instance.imageUrl,
      'averageRating': instance.averageRating,
      'approvedCourseCount': instance.approvedCourseCount,
      'studentCount': instance.studentCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
