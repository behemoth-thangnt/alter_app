import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/course_collection.dart';

abstract class CourseRepository {
  Future<Either<Failure, CourseCollection>> getUserCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  });

  Future<Either<Failure, CourseCollection>> getMyCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  });
}
