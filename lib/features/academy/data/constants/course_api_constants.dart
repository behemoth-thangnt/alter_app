class CourseApiConstants {
  // GraphQL Operations for Courses
  static const String coursesQuery = '''
    query Courses(\$first: Int, \$after: String, \$filter: CourseFilter) {
      courses(first: \$first, after: \$after, filter: \$filter) {
        edges {
          node {
            id
            title
            description
            imageUrl
            price
            duration
            level
            isActive
            teacher {
              id
              name
              slug
              imageUrl
            }
            createdAt
            updatedAt
          }
        }
        pageInfo {
          hasNextPage
          hasPreviousPage
          startCursor
          endCursor
        }
        totalCount
      }
    }
  ''';

  static const String courseQuery = '''
    query Course(\$id: ID!) {
      course(id: \$id) {
        id
        title
        description
        imageUrl
        price
        duration
        level
        isActive
        teacher {
          id
          name
          slug
          imageUrl
        }
        createdAt
        updatedAt
      }
    }
  ''';

  static const String enrollCourseMutation = '''
    mutation EnrollCourse(\$courseId: ID!) {
      enrollCourse(courseId: \$courseId) {
        id
        enrolledAt
        progress
        status
        course {
          id
          title
        }
      }
    }
  ''';

  static const String myCourseProgressQuery = '''
    query MyCourseProgress(\$courseId: ID!) {
      myCourseProgress(courseId: \$courseId) {
        id
        progress
        completedLessons
        totalLessons
        lastAccessedAt
        course {
          id
          title
        }
      }
    }
  ''';

  // Legacy query names for backward compatibility
  static String get userCoursesQuery => coursesQuery;
  static String get myCoursesQuery => coursesQuery;
}
