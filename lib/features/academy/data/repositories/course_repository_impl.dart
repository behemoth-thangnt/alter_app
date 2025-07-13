import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/course_collection.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_local_data_source.dart';
import '../datasources/course_remote_data_source.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;
  final CourseLocalDataSource localDataSource;

  CourseRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, CourseCollection>> getUserCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  }) async {
    final cacheKey = _generateCacheKey(
      page: page,
      perPage: perPage,
      titleCont: titleCont,
      categoryCont: categoryCont,
      teacherNameCont: teacherNameCont,
      salePriceRange: salePriceRange,
    );

    try {
      final remoteCourses = await remoteDataSource.getUserCourses(
        page: page,
        perPage: perPage,
        titleCont: titleCont,
        categoryCont: categoryCont,
        teacherNameCont: teacherNameCont,
        salePriceRange: salePriceRange,
      );

      await localDataSource.cacheUserCourses(cacheKey, remoteCourses);
      return Right(remoteCourses);
    } on OperationException catch (e) {
      // Try to get cached data when network fails
      try {
        final cachedCourses =
            await localDataSource.getCachedUserCourses(cacheKey);
        if (cachedCourses != null) {
          return Right(cachedCourses);
        }
        return Left(NetworkFailure(_getGraphQLErrorMessage(e)));
      } catch (cacheError) {
        return Left(NetworkFailure(_getGraphQLErrorMessage(e)));
      }
    } catch (e) {
      try {
        final cachedCourses =
            await localDataSource.getCachedUserCourses(cacheKey);
        if (cachedCourses != null) {
          return Right(cachedCourses);
        }
        return Left(ServerFailure(e.toString()));
      } catch (cacheError) {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, CourseCollection>> getMyCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  }) async {
    final cacheKey = _generateCacheKey(
      page: page,
      perPage: perPage,
      titleCont: titleCont,
      categoryCont: categoryCont,
      teacherNameCont: teacherNameCont,
      salePriceRange: salePriceRange,
    );

    try {
      final remoteCourses = await remoteDataSource.getMyCourses(
        page: page,
        perPage: perPage,
        titleCont: titleCont,
        categoryCont: categoryCont,
        teacherNameCont: teacherNameCont,
        salePriceRange: salePriceRange,
      );

      await localDataSource.cacheMyCourses(cacheKey, remoteCourses);
      return Right(remoteCourses);
    } on OperationException catch (e) {
      // Try to get cached data when network fails
      try {
        final cachedCourses =
            await localDataSource.getCachedMyCourses(cacheKey);
        if (cachedCourses != null) {
          return Right(cachedCourses);
        }
        return Left(NetworkFailure(_getGraphQLErrorMessage(e)));
      } catch (cacheError) {
        return Left(NetworkFailure(_getGraphQLErrorMessage(e)));
      }
    } catch (e) {
      try {
        final cachedCourses =
            await localDataSource.getCachedMyCourses(cacheKey);
        if (cachedCourses != null) {
          return Right(cachedCourses);
        }
        return Left(ServerFailure(e.toString()));
      } catch (cacheError) {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  String _generateCacheKey({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  }) {
    final parts = [
      if (page != null) 'p$page',
      if (perPage != null) 'pp$perPage',
      if (titleCont != null) 't${titleCont.hashCode}',
      if (categoryCont != null) 'c${categoryCont.hashCode}',
      if (teacherNameCont != null) 'tn${teacherNameCont.hashCode}',
      if (salePriceRange != null) 'spr${salePriceRange.hashCode}',
    ];
    return parts.join('_');
  }

  String _getGraphQLErrorMessage(OperationException error) {
    if (error.graphqlErrors.isNotEmpty) {
      return error.graphqlErrors.first.message;
    }
    if (error.linkException != null) {
      return 'Network error occurred';
    }
    return 'Unknown GraphQL error';
  }
}
