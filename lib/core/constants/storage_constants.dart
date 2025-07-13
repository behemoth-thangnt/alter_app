class StorageConstants {
  // Hive Box Names
  static const String authBox = 'auth_box';
  static const String userBox = 'user_box';
  static const String courseBox = 'course_box';
  static const String cacheBox = 'cache_box';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userProfileKey = 'user_profile';
  static const String isLoggedInKey = 'is_logged_in';
  static const String languageKey = 'language';
  static const String themeKey = 'theme';

  // Cache Keys
  static const String userCoursesKey = 'user_courses';
  static const String myCoursesKey = 'my_courses';
  static const String selfInfoKey = 'self_info';

  // Cache Duration (in hours)
  static const int cacheExpiryHours = 24;
}
