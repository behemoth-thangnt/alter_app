import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  final int id;
  final String name;
  final bool active;
  final String? award;
  final String? address;
  final String? phoneNumber;
  final String slug;
  final String? contactEmail;
  final String? description;
  final bool basicEntered;
  final bool canInviteStudents;
  final String? imageUrl;
  final double? averageRating;
  final int approvedCourseCount;
  final int studentCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Teacher({
    required this.id,
    required this.name,
    required this.active,
    this.award,
    this.address,
    this.phoneNumber,
    required this.slug,
    this.contactEmail,
    this.description,
    required this.basicEntered,
    required this.canInviteStudents,
    this.imageUrl,
    this.averageRating,
    required this.approvedCourseCount,
    required this.studentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        active,
        award,
        address,
        phoneNumber,
        slug,
        contactEmail,
        description,
        basicEntered,
        canInviteStudents,
        imageUrl,
        averageRating,
        approvedCourseCount,
        studentCount,
        createdAt,
        updatedAt,
      ];
}
