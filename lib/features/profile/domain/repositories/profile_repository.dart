import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/entities/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getSelfInfo();
  Future<Either<Failure, void>> updateSelfInfo({
    String? name,
    String? gender,
    String? birthDate,
    String? imageUrl,
  });
}
