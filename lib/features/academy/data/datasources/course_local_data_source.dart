import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/storage_constants.dart';
import '../models/course_collection_model.dart';

abstract class CourseLocalDataSource {
  Future<CourseCollectionModel?> getCachedUserCourses(String cacheKey);
  Future<void> cacheUserCourses(String cacheKey, CourseCollectionModel courses);
  Future<CourseCollectionModel?> getCachedMyCourses(String cacheKey);
  Future<void> cacheMyCourses(String cacheKey, CourseCollectionModel courses);
  Future<void> clearCache();
}

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  @override
  Future<CourseCollectionModel?> getCachedUserCourses(String cacheKey) async {
    try {
      final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
      final cachedData =
          cacheBox.get('${StorageConstants.userCoursesKey}_$cacheKey');

      if (cachedData != null) {
        final coursesData = json.decode(cachedData) as Map<String, dynamic>;
        return CourseCollectionModel.fromJson(coursesData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheUserCourses(
      String cacheKey, CourseCollectionModel courses) async {
    final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
    final coursesJson = json.encode(courses.toJson());
    await cacheBox.put(
        '${StorageConstants.userCoursesKey}_$cacheKey', coursesJson);
  }

  @override
  Future<CourseCollectionModel?> getCachedMyCourses(String cacheKey) async {
    try {
      final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
      final cachedData =
          cacheBox.get('${StorageConstants.myCoursesKey}_$cacheKey');

      if (cachedData != null) {
        final coursesData = json.decode(cachedData) as Map<String, dynamic>;
        return CourseCollectionModel.fromJson(coursesData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheMyCourses(
      String cacheKey, CourseCollectionModel courses) async {
    final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
    final coursesJson = json.encode(courses.toJson());
    await cacheBox.put(
        '${StorageConstants.myCoursesKey}_$cacheKey', coursesJson);
  }

  @override
  Future<void> clearCache() async {
    final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
    final keys = cacheBox.keys
        .where((key) =>
            key.toString().startsWith(StorageConstants.userCoursesKey) ||
            key.toString().startsWith(StorageConstants.myCoursesKey))
        .toList();

    for (final key in keys) {
      await cacheBox.delete(key);
    }
  }
}
