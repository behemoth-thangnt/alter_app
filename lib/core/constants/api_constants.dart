import 'package:flutter/foundation.dart';

class ApiConstants {
  // Base URLs
  static String get baseUrl {
    if (kDebugMode) {
      // For iOS simulator, use 127.0.0.1 instead of localhost
      // For Android emulator, use 10.0.2.2
      // For physical devices, use your computer's IP address
      return 'http://127.0.0.1:3006';
    }
    return 'https://api.billiard-ecosystem.com';
  }

  static String get publicGraphQLEndpoint => '$baseUrl/graphql/public';
  static String get userGraphQLEndpoint => '$baseUrl/graphql/user';

  // Logging Configuration
  static const bool enableStatusLogging =
      true; // Log operation status (success/error)
  static const bool enableErrorLogging = true; // Log error details
  static const bool enableDetailedLogging =
      false; // Only for debugging specific issues

  // GraphQL Operations
  static const String signInMutation = '''
    mutation SignIn(\$input: SignInInput!) {
      signIn(input: \$input) {
        profile {
          id
          username
          email
          phoneNumber
          teacher {
            id
            name
            slug
            imageUrl
          }
          user {
            id
            name
            imageUrl
            phoneNumber
            gender
            birthDate
            createdAt
            updatedAt
          }
        }
        accessToken
        refreshToken
        message
      }
    }
  ''';

  static const String selfInfoQuery = '''
    query SelfInfo {
      selfInfo {
        id
        name
        active
        imageUrl
        phoneNumber
        gender
        birthDate
        createdAt
        updatedAt
        unreadNotificationCount
      }
    }
  ''';

  static const String userCoursesQuery = '''
    query UserCourses(\$input: PagyInput, \$query: CourseQueryInput) {
      userCourses(input: \$input, query: \$query) {
        collection {
          id
          teacherId
          title
          slug
          description
          salePrice
          price
          bonusPoint
          status
          instructionalLevel
          sectionCount
          sectionItemCount
          joinedUserCount
          banner
          isPublic
          averageRating
          teacher {
            id
            name
            slug
            imageUrl
          }
          joined
          processPercent
          createdAt
          updatedAt
        }
        metadata {
          total
          perPage
          page
          pages
          count
        }
      }
    }
  ''';

  static const String myCoursesQuery = '''
    query MyCourses(\$input: PagyInput, \$query: CourseQueryInput) {
      myCourses(input: \$input, query: \$query) {
        collection {
          id
          teacherId
          title
          slug
          description
          salePrice
          price
          bonusPoint
          status
          sectionCount
          sectionItemCount
          joinedUserCount
          banner
          isPublic
          teacher {
            id
            name
            slug
            imageUrl
          }
          joined
          processPercent
          createdAt
          updatedAt
        }
        metadata {
          total
          perPage
          page
          pages
          count
        }
      }
    }
  ''';

  static const String updateSelfInfoMutation = '''
    mutation UpdateSelfInfo(\$input: SelfInfoInput!) {
      updateSelfInfo(input: \$input) {
        message
      }
    }
  ''';
}
