import 'package:equatable/equatable.dart';
import 'course.dart';

class CourseCollection extends Equatable {
  final List<Course> courses;
  final CourseMetadata metadata;

  const CourseCollection({
    required this.courses,
    required this.metadata,
  });

  @override
  List<Object> get props => [courses, metadata];
}

class CourseMetadata extends Equatable {
  final int? total;
  final int? perPage;
  final int? page;
  final int? pages;
  final int? count;
  final int? next;
  final int? prev;
  final int? from;
  final int? to;

  const CourseMetadata({
    this.total,
    this.perPage,
    this.page,
    this.pages,
    this.count,
    this.next,
    this.prev,
    this.from,
    this.to,
  });

  @override
  List<Object?> get props => [
        total,
        perPage,
        page,
        pages,
        count,
        next,
        prev,
        from,
        to,
      ];

  bool get hasNextPage => next != null;
  bool get hasPreviousPage => prev != null;
}
