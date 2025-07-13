class AuthApiConstants {
  // GraphQL Operations for Authentication
  static const String signInMutation = '''
    mutation SignIn(\$identifier: String!, \$password: String!) {
      signIn(input: { identifier: \$identifier, password: \$password }) {
        profile {
          id
          username
          email
          phoneNumber
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

  static const String refreshTokenMutation = '''
    mutation RefreshToken(\$refreshToken: String!) {
      refreshToken(refreshToken: \$refreshToken) {
        accessToken
        refreshToken
        expiresIn
      }
    }
  ''';

  static const String signOutMutation = '''
    mutation SignOut {
      signOut {
        success
        message
      }
    }
  ''';

  static const String getCurrentProfileQuery = '''
    query GetCurrentProfile {
      getCurrentProfile {
        id
        username
        email
        phoneNumber
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
    }
  ''';
}
