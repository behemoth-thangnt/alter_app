import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/course_collection.dart';
import '../repositories/course_repository.dart';

class GetUserCoursesUseCase
    implements UseCase<CourseCollection, GetUserCoursesParams> {
  final CourseRepository repository;

  GetUserCoursesUseCase(this.repository);

  @override
  Future<Either<Failure, CourseCollection>> call(
      GetUserCoursesParams params) async {
    return await repository.getUserCourses(
      page: params.page,
      perPage: params.perPage,
      titleCont: params.titleCont,
      categoryCont: params.categoryCont,
      teacherNameCont: params.teacherNameCont,
      salePriceRange: params.salePriceRange,
    );
  }
}

class GetUserCoursesParams extends Equatable {
  final int? page;
  final int? perPage;
  final String? titleCont;
  final String? categoryCont;
  final String? teacherNameCont;
  final List<int>? salePriceRange;

  const GetUserCoursesParams({
    this.page,
    this.perPage,
    this.titleCont,
    this.categoryCont,
    this.teacherNameCont,
    this.salePriceRange,
  });

  @override
  List<Object?> get props => [
        page,
        perPage,
        titleCont,
        categoryCont,
        teacherNameCont,
        salePriceRange,
      ];
}
