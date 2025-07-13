import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../storage/secure_storage.dart';

part 'core_providers.g.dart';

@riverpod
SecureStorage secureStorage(SecureStorageRef ref) {
  return SecureStorage();
}

@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async {
  return await SharedPreferences.getInstance();
}
