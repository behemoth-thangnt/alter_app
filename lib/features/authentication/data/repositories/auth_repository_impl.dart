import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/graphql_client.dart';
import '../../domain/entities/auth_profile.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthProfile>> signIn({
    required String identifier,
    required String password,
  }) async {
    try {
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
        final exception = result.exception;
        if (exception?.graphqlErrors.isNotEmpty == true) {
          return Left(AuthFailure(exception!.graphqlErrors.first.message));
        }
        if (exception?.linkException != null) {
          final linkException = exception!.linkException;
          String errorMessage = 'Network error occurred';

          if (linkException is NetworkException) {
            errorMessage =
                'Không thể kết nối đến server. Vui lòng kiểm tra kết nối mạng.';
          } else if (linkException is ServerException) {
            errorMessage =
                'Server error: ${linkException.originalException?.toString() ?? 'Unknown server error'}';
          } else {
            errorMessage = 'Connection error: ${linkException.toString()}';
          }

          return Left(NetworkFailure(errorMessage));
        }
        return const Left(AuthFailure('Sign in failed'));
      }

      final data = result.data?['signIn'];
      if (data == null) {
        return const Left(AuthFailure('No data received from server'));
      }

      final profileData = data['profile'];
      final accessToken = data['accessToken'] as String?;
      final refreshToken = data['refreshToken'] as String?;

      if (profileData == null || accessToken == null || refreshToken == null) {
        return const Left(AuthFailure('Invalid response from server'));
      }

      // Parse profile data manually since we need to handle nested objects
      final profile = AuthProfile(
        id: profileData['id'] as String,
        username: profileData['username'] as String?,
        email: profileData['email'] as String?,
        phoneNumber: profileData['phoneNumber'] as String?,
        user: _parseUser(profileData['user']),
      );

      // Save authentication data locally
      await localDataSource.saveAuthData(
        profile: _profileToModel(profile),
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      // Reset GraphQL clients to use new token
      GraphQLClientService.resetClients();

      return Right(profile);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await localDataSource.clearAuthData();
      GraphQLClientService.resetClients();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshToken() async {
    try {
      final refreshToken = await localDataSource.getRefreshToken();
      if (refreshToken == null) {
        return const Left(AuthFailure('No refresh token available'));
      }

      // TODO: Implement refresh token logic based on your API
      // For now, we'll return a failure since it's not in the GraphQL schema
      return const Left(AuthFailure('Token refresh not implemented'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final isLoggedIn = await localDataSource.isLoggedIn();
      return Right(isLoggedIn);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthProfile?>> getCurrentProfile() async {
    try {
      final profileModel = await localDataSource.getCachedProfile();
      return Right(profileModel);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  // Helper methods for parsing nested objects
  AuthUserModel _parseUser(Map<String, dynamic> userData) {
    return AuthUserModel.fromJson(userData);
  }

  AuthProfileModel _profileToModel(AuthProfile profile) {
    return AuthProfileModel.fromEntity(profile);
  }
}
