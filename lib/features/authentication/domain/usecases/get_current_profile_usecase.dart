import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_profile.dart';
import '../repositories/auth_repository.dart';

class GetCurrentProfileUseCase implements UseCase<AuthProfile?, NoParams> {
  final AuthRepository repository;

  GetCurrentProfileUseCase(this.repository);

  @override
  Future<Either<Failure, AuthProfile?>> call(NoParams params) async {
    return await repository.getCurrentProfile();
  }
}
