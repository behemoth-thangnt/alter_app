import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_profile.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase implements UseCase<AuthProfile, SignInParams> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, AuthProfile>> call(SignInParams params) async {
    return await repository.signIn(
      identifier: params.identifier,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String identifier;
  final String password;

  const SignInParams({
    required this.identifier,
    required this.password,
  });

  @override
  List<Object> get props => [identifier, password];
}
