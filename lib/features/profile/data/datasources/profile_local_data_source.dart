import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../authentication/data/models/user_model.dart';

abstract class ProfileLocalDataSource {
  Future<UserModel?> getCachedSelfInfo();
  Future<void> cacheSelfInfo(UserModel user);
  Future<void> clearCache();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<UserModel?> getCachedSelfInfo() async {
    try {
      final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
      final cachedData = cacheBox.get(StorageConstants.selfInfoKey);

      if (cachedData != null) {
        final userData = json.decode(cachedData) as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheSelfInfo(UserModel user) async {
    final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
    final userJson = json.encode(user.toJson());
    await cacheBox.put(StorageConstants.selfInfoKey, userJson);
  }

  @override
  Future<void> clearCache() async {
    final cacheBox = await Hive.openBox<String>(StorageConstants.cacheBox);
    await cacheBox.delete(StorageConstants.selfInfoKey);
  }
}
