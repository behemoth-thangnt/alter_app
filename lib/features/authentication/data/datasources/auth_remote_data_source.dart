import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/graphql_client.dart';
import '../models/auth_profile_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthProfileModel> signIn({
    required String identifier,
    required String password,
  });

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthProfileModel> signIn({
    required String identifier,
    required String password,
  }) async {
    final result = await GraphQLClientService.executeMutation(
      mutation: ApiConstants.signInMutation,
      variables: {
        'input': {
          'identifier': identifier,
          'password': password,
        },
      },
      requiresAuth: false,
    );

    if (result.hasException) {
      throw Exception(result.exception?.toString() ?? 'Sign in failed');
    }

    final data = result.data?['signIn'];
    if (data == null) {
      throw Exception('No data received from sign in');
    }

    // Extract profile data
    final profileData = data['profile'];
    if (profileData == null) {
      throw Exception('No profile data received');
    }

    return AuthProfileModel.fromJson(profileData);
  }

  @override
  Future<void> signOut() async {
    // For GraphQL, we typically just clear local storage
    // No specific logout mutation needed based on the schema
    return;
  }
}
