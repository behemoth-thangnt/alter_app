class AssignmentApiConstants {
  // GraphQL Operations for Assignments
  static const String assignmentsQuery = '''
    query Assignments(\$first: Int, \$after: String, \$filter: AssignmentFilter) {
      assignments(first: \$first, after: \$after, filter: \$filter) {
        edges {
          node {
            id
            title
            description
            dueDate
            status
            course {
              id
              title
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

  static const String assignmentQuery = '''
    query Assignment(\$id: ID!) {
      assignment(id: \$id) {
        id
        title
        description
        dueDate
        status
        course {
          id
          title
        }
        createdAt
        updatedAt
      }
    }
  ''';

  static const String submitAssignmentMutation = '''
    mutation SubmitAssignment(\$assignmentId: ID!, \$submission: String!) {
      submitAssignment(assignmentId: \$assignmentId, submission: \$submission) {
        id
        submittedAt
        grade
        feedback
        status
        assignment {
          id
          title
        }
      }
    }
  ''';

  static const String myAssignmentSubmissionsQuery = '''
    query MyAssignmentSubmissions(\$assignmentId: ID!) {
      myAssignmentSubmissions(assignmentId: \$assignmentId) {
        id
        submittedAt
        grade
        feedback
        status
        assignment {
          id
          title
          dueDate
        }
      }
    }
  ''';
}
