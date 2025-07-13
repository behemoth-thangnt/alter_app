import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      // If .env file doesn't exist, use default values
      if (kDebugMode) {
        print('Warning: .env file not found, using default values');
      }
    }
  }

  // Environment-specific getters with fallbacks
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://127.0.0.1:3006';
  static String get apiPublicEndpoint =>
      dotenv.env['API_PUBLIC_ENDPOINT'] ?? '/graphql/public';
  static String get apiUserEndpoint =>
      dotenv.env['API_USER_ENDPOINT'] ?? '/graphql/user';
  static bool get debugMode =>
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
  static String get logLevel => dotenv.env['LOG_LEVEL'] ?? 'info';

  // Computed properties
  static String get publicApiUrl => '$apiBaseUrl$apiPublicEndpoint';
  static String get userApiUrl => '$apiBaseUrl$apiUserEndpoint';

  // Environment detection based on debug mode and API URL
  static bool get isDevelopment =>
      debugMode && apiBaseUrl.contains('127.0.0.1');

  // Debug info
  static Map<String, dynamic> get debugInfo => {
        'apiBaseUrl': apiBaseUrl,
        'publicApiUrl': publicApiUrl,
        'userApiUrl': userApiUrl,
        'debugMode': debugMode,
        'logLevel': logLevel,
        'isDevelopment': isDevelopment,
      };
}
