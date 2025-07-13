import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/course_collection.dart';
import 'course_model.dart';

part 'course_collection_model.g.dart';

@JsonSerializable()
class CourseCollectionModel extends CourseCollection {
  @JsonKey(name: 'collection')
  final List<CourseModel> courseModels;

  @JsonKey(name: 'metadata')
  final CourseMetadataModel metadataModel;

  const CourseCollectionModel({
    required this.courseModels,
    required this.metadataModel,
  }) : super(
          courses: courseModels,
          metadata: metadataModel,
        );

  factory CourseCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCollectionModelToJson(this);
}

@JsonSerializable()
class CourseMetadataModel extends CourseMetadata {
  const CourseMetadataModel({
    super.total,
    super.perPage,
    super.page,
    super.pages,
    super.count,
    super.next,
    super.prev,
    super.from,
    super.to,
  });

  factory CourseMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$CourseMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseMetadataModelToJson(this);
}
