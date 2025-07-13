// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: (json['id'] as num).toInt(),
      teacherId: (json['teacherId'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      salePrice: (json['salePrice'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      bonusPoint: (json['bonusPoint'] as num?)?.toInt(),
      status: json['status'] as String,
      instructionalLevel: json['instructionalLevel'] as String?,
      bonusPointPercent: (json['bonusPointPercent'] as num?)?.toInt(),
      sectionCount: (json['sectionCount'] as num).toInt(),
      sectionItemCount: (json['sectionItemCount'] as num).toInt(),
      joinedUserCount: (json['joinedUserCount'] as num).toInt(),
      banner: json['banner'] as String?,
      isPublic: json['isPublic'] as bool,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      teacherModel: json['teacher'] == null
          ? null
          : TeacherModel.fromJson(json['teacher'] as Map<String, dynamic>),
      joined: json['joined'] as bool,
      processPercent: (json['processPercent'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teacherId': instance.teacherId,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'salePrice': instance.salePrice,
      'price': instance.price,
      'bonusPoint': instance.bonusPoint,
      'status': instance.status,
      'instructionalLevel': instance.instructionalLevel,
      'bonusPointPercent': instance.bonusPointPercent,
      'sectionCount': instance.sectionCount,
      'sectionItemCount': instance.sectionItemCount,
      'joinedUserCount': instance.joinedUserCount,
      'banner': instance.banner,
      'isPublic': instance.isPublic,
      'averageRating': instance.averageRating,
      'joined': instance.joined,
      'processPercent': instance.processPercent,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'teacher': instance.teacherModel,
    };
