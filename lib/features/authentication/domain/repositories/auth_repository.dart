import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_profile.dart';
import '../entities/auth_tokens.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthProfile>> signIn({
    required String identifier,
    required String password,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, AuthTokens>> refreshToken();

  Future<Either<Failure, bool>> isLoggedIn();

  Future<Either<Failure, AuthProfile?>> getCurrentProfile();
}
