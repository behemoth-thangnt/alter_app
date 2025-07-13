import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/teacher.dart';

part 'teacher_model.g.dart';

@JsonSerializable()
class TeacherModel extends Teacher {
  const TeacherModel({
    required super.id,
    required super.name,
    required super.active,
    super.award,
    super.address,
    super.phoneNumber,
    required super.slug,
    super.contactEmail,
    super.description,
    required super.basicEntered,
    required super.canInviteStudents,
    super.imageUrl,
    super.averageRating,
    required super.approvedCourseCount,
    required super.studentCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);

  factory TeacherModel.fromEntity(Teacher teacher) {
    return TeacherModel(
      id: teacher.id,
      name: teacher.name,
      active: teacher.active,
      award: teacher.award,
      address: teacher.address,
      phoneNumber: teacher.phoneNumber,
      slug: teacher.slug,
      contactEmail: teacher.contactEmail,
      description: teacher.description,
      basicEntered: teacher.basicEntered,
      canInviteStudents: teacher.canInviteStudents,
      imageUrl: teacher.imageUrl,
      averageRating: teacher.averageRating,
      approvedCourseCount: teacher.approvedCourseCount,
      studentCount: teacher.studentCount,
      createdAt: teacher.createdAt,
      updatedAt: teacher.updatedAt,
    );
  }
}
