import '../../../../core/network/graphql_client.dart';
import '../../../authentication/data/models/user_model.dart';
import '../constants/profile_api_constants.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getSelfInfo();
  Future<void> updateSelfInfo({
    String? name,
    String? gender,
    String? birthDate,
    String? imageUrl,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<UserModel> getSelfInfo() async {
    final result = await GraphQLClientService.executeQuery(
      query: ProfileApiConstants.selfInfoQuery,
      requiresAuth: true,
    );

    if (result.hasException) {
      throw Exception(
          result.exception?.toString() ?? 'Failed to get self info');
    }

    final data = result.data?['selfInfo'];
    if (data == null) {
      throw Exception('No self info data received');
    }

    return UserModel.fromJson(data);
  }

  @override
  Future<void> updateSelfInfo({
    String? name,
    String? gender,
    String? birthDate,
    String? imageUrl,
  }) async {
    final variables = <String, dynamic>{};
    if (name != null) variables['name'] = name;
    if (gender != null) variables['gender'] = gender;
    if (birthDate != null) variables['birthDate'] = birthDate;
    if (imageUrl != null) variables['imageUrl'] = imageUrl;

    final result = await GraphQLClientService.executeMutation(
      mutation: ProfileApiConstants.updateSelfInfoMutation,
      variables: {
        'input': variables,
      },
      requiresAuth: true,
    );

    if (result.hasException) {
      throw Exception(
          result.exception?.toString() ?? 'Failed to update self info');
    }
  }
}
