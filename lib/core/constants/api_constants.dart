import '../config/environment_config.dart';

class ApiConstants {
  // Base URLs from environment configuration
  static String get baseUrl => EnvironmentConfig.apiBaseUrl;
  static String get publicGraphQLEndpoint => EnvironmentConfig.publicApiUrl;
  static String get userGraphQLEndpoint => EnvironmentConfig.userApiUrl;

  // Logging Configuration from environment
  static bool get enableStatusLogging => EnvironmentConfig.debugMode;
  static bool get enableErrorLogging => EnvironmentConfig.debugMode;
  static bool get enableDetailedLogging => EnvironmentConfig.debugMode;

  // Request Configuration
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
