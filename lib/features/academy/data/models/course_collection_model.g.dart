// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCollectionModel _$CourseCollectionModelFromJson(
        Map<String, dynamic> json) =>
    CourseCollectionModel(
      courseModels: (json['collection'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadataModel: CourseMetadataModel.fromJson(
          json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseCollectionModelToJson(
        CourseCollectionModel instance) =>
    <String, dynamic>{
      'collection': instance.courseModels,
      'metadata': instance.metadataModel,
    };

CourseMetadataModel _$CourseMetadataModelFromJson(Map<String, dynamic> json) =>
    CourseMetadataModel(
      total: (json['total'] as num?)?.toInt(),
      perPage: (json['perPage'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      next: (json['next'] as num?)?.toInt(),
      prev: (json['prev'] as num?)?.toInt(),
      from: (json['from'] as num?)?.toInt(),
      to: (json['to'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseMetadataModelToJson(
        CourseMetadataModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'perPage': instance.perPage,
      'page': instance.page,
      'pages': instance.pages,
      'count': instance.count,
      'next': instance.next,
      'prev': instance.prev,
      'from': instance.from,
      'to': instance.to,
    };
