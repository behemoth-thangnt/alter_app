import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../shared/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class GetSelfInfoUseCase implements UseCase<User, NoParams> {
  final ProfileRepository repository;

  GetSelfInfoUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getSelfInfo();
  }
}
