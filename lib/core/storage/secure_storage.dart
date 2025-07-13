import 'package:hive_flutter/hive_flutter.dart';
import '../constants/storage_constants.dart';

class SecureStorage {
  static Box<String>? _authBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _authBox = await Hive.openBox<String>(StorageConstants.authBox);
  }

  static Box<String> get authBox {
    if (_authBox == null) {
      throw Exception('SecureStorage not initialized. Call init() first.');
    }
    return _authBox!;
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await authBox.put(StorageConstants.accessTokenKey, accessToken);
    await authBox.put(StorageConstants.refreshTokenKey, refreshToken);
    await authBox.put(StorageConstants.isLoggedInKey, 'true');
  }

  Future<String?> getAccessToken() async {
    return authBox.get(StorageConstants.accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return authBox.get(StorageConstants.refreshTokenKey);
  }

  Future<bool> isLoggedIn() async {
    return authBox.get(StorageConstants.isLoggedInKey) == 'true';
  }

  Future<void> clearTokens() async {
    await authBox.delete(StorageConstants.accessTokenKey);
    await authBox.delete(StorageConstants.refreshTokenKey);
    await authBox.delete(StorageConstants.isLoggedInKey);
  }

  Future<void> clearAll() async {
    await authBox.clear();
  }
}
