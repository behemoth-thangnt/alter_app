import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> getSelfInfo() async {
    try {
      final remoteUser = await remoteDataSource.getSelfInfo();
      await localDataSource.cacheSelfInfo(remoteUser);
      return Right(remoteUser);
    } on OperationException catch (e) {
      // Try to get cached data when network fails
      try {
        final cachedUser = await localDataSource.getCachedSelfInfo();
        if (cachedUser != null) {
          return Right(cachedUser);
        }
        return Left(NetworkFailure(_getGraphQLErrorMessage(e)));
      } catch (cacheError) {
        return Left(NetworkFailure(_getGraphQLErrorMessage(e)));
      }
    } catch (e) {
      try {
        final cachedUser = await localDataSource.getCachedSelfInfo();
        if (cachedUser != null) {
          return Right(cachedUser);
        }
        return Left(ServerFailure(e.toString()));
      } catch (cacheError) {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateSelfInfo({
    String? name,
    String? gender,
    String? birthDate,
    String? imageUrl,
  }) async {
    try {
      await remoteDataSource.updateSelfInfo(
        name: name,
        gender: gender,
        birthDate: birthDate,
        imageUrl: imageUrl,
      );

      // Clear cache after successful update so fresh data is fetched next time
      await localDataSource.clearCache();

      return const Right(null);
    } on OperationException catch (e) {
      return Left(NetworkFailure(_getGraphQLErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _getGraphQLErrorMessage(OperationException error) {
    if (error.graphqlErrors.isNotEmpty) {
      return error.graphqlErrors.first.message;
    }
    if (error.linkException != null) {
      return 'Network error occurred';
    }
    return 'Unknown GraphQL error';
  }
}
