import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/auth_profile_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData({
    required AuthProfileModel profile,
    required String accessToken,
    required String refreshToken,
  });

  Future<AuthProfileModel?> getCachedProfile();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<bool> isLoggedIn();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveAuthData({
    required AuthProfileModel profile,
    required String accessToken,
    required String refreshToken,
  }) async {
    // Save tokens securely
    await secureStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    // Save profile data
    final profileBox = await Hive.openBox<String>(StorageConstants.userBox);
    final profileJson = json.encode(profile.toJson());
    await profileBox.put(StorageConstants.userProfileKey, profileJson);
  }

  @override
  Future<AuthProfileModel?> getCachedProfile() async {
    try {
      final profileBox = await Hive.openBox<String>(StorageConstants.userBox);
      final profileJson = profileBox.get(StorageConstants.userProfileKey);

      if (profileJson != null) {
        final profileMap = json.decode(profileJson) as Map<String, dynamic>;
        return AuthProfileModel.fromJson(profileMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await secureStorage.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.getRefreshToken();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await secureStorage.isLoggedIn();
  }

  @override
  Future<void> clearAuthData() async {
    await secureStorage.clearTokens();

    final profileBox = await Hive.openBox<String>(StorageConstants.userBox);
    await profileBox.delete(StorageConstants.userProfileKey);
  }
}
