import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/graphql_client.dart';
import '../models/course_collection_model.dart';

abstract class CourseRemoteDataSource {
  Future<CourseCollectionModel> getUserCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  });

  Future<CourseCollectionModel> getMyCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  });
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  @override
  Future<CourseCollectionModel> getUserCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  }) async {
    final variables = <String, dynamic>{};

    // Pagination input
    if (page != null || perPage != null) {
      variables['input'] = <String, dynamic>{};
      if (page != null) variables['input']['page'] = page;
      if (perPage != null) variables['input']['perPage'] = perPage;
    }

    // Query input
    if (titleCont != null ||
        categoryCont != null ||
        teacherNameCont != null ||
        salePriceRange != null) {
      variables['query'] = <String, dynamic>{};
      if (titleCont != null) {
        variables['query']['titleCont'] = titleCont;
      }
      if (categoryCont != null) {
        variables['query']['categoryCont'] = categoryCont;
      }
      if (teacherNameCont != null) {
        variables['query']['teacherNameCont'] = teacherNameCont;
      }
      if (salePriceRange != null) {
        variables['query']['salePriceRange'] = salePriceRange;
      }
    }

    final result = await GraphQLClientService.executeQuery(
      query: ApiConstants.userCoursesQuery,
      variables: variables,
      requiresAuth: true,
    );

    if (result.hasException) {
      throw Exception(
          result.exception?.toString() ?? 'Failed to get user courses');
    }

    final data = result.data?['userCourses'];
    if (data == null) {
      throw Exception('No user courses data received');
    }

    return CourseCollectionModel.fromJson(data);
  }

  @override
  Future<CourseCollectionModel> getMyCourses({
    int? page,
    int? perPage,
    String? titleCont,
    String? categoryCont,
    String? teacherNameCont,
    List<int>? salePriceRange,
  }) async {
    final variables = <String, dynamic>{};

    // Pagination input
    if (page != null || perPage != null) {
      variables['input'] = <String, dynamic>{};
      if (page != null) variables['input']['page'] = page;
      if (perPage != null) variables['input']['perPage'] = perPage;
    }

    // Query input
    if (titleCont != null ||
        categoryCont != null ||
        teacherNameCont != null ||
        salePriceRange != null) {
      variables['query'] = <String, dynamic>{};
      if (titleCont != null) {
        variables['query']['titleCont'] = titleCont;
      }
      if (categoryCont != null) {
        variables['query']['categoryCont'] = categoryCont;
      }
      if (teacherNameCont != null) {
        variables['query']['teacherNameCont'] = teacherNameCont;
      }
      if (salePriceRange != null) {
        variables['query']['salePriceRange'] = salePriceRange;
      }
    }

    final result = await GraphQLClientService.executeQuery(
      query: ApiConstants.myCoursesQuery,
      variables: variables,
      requiresAuth: true,
    );

    if (result.hasException) {
      throw Exception(
          result.exception?.toString() ?? 'Failed to get my courses');
    }

    final data = result.data?['myCourses'];
    if (data == null) {
      throw Exception('No my courses data received');
    }

    return CourseCollectionModel.fromJson(data);
  }
}
