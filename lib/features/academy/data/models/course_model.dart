import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/course.dart';
import '../../../../shared/data/models/teacher_model.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel extends Course {
  @JsonKey(name: 'teacher')
  final TeacherModel? teacherModel;

  const CourseModel({
    required super.id,
    required super.teacherId,
    required super.title,
    required super.slug,
    super.description,
    super.salePrice,
    super.price,
    super.bonusPoint,
    required super.status,
    super.instructionalLevel,
    super.bonusPointPercent,
    required super.sectionCount,
    required super.sectionItemCount,
    required super.joinedUserCount,
    super.banner,
    required super.isPublic,
    super.averageRating,
    this.teacherModel,
    required super.joined,
    required super.processPercent,
    super.createdAt,
    super.updatedAt,
  }) : super(teacher: teacherModel);

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  factory CourseModel.fromEntity(Course course) {
    return CourseModel(
      id: course.id,
      teacherId: course.teacherId,
      title: course.title,
      slug: course.slug,
      description: course.description,
      salePrice: course.salePrice,
      price: course.price,
      bonusPoint: course.bonusPoint,
      status: course.status,
      instructionalLevel: course.instructionalLevel,
      bonusPointPercent: course.bonusPointPercent,
      sectionCount: course.sectionCount,
      sectionItemCount: course.sectionItemCount,
      joinedUserCount: course.joinedUserCount,
      banner: course.banner,
      isPublic: course.isPublic,
      averageRating: course.averageRating,
      teacherModel: course.teacher != null
          ? TeacherModel.fromEntity(course.teacher!)
          : null,
      joined: course.joined,
      processPercent: course.processPercent,
      createdAt: course.createdAt,
      updatedAt: course.updatedAt,
    );
  }
}
