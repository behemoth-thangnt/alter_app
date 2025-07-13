import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class UpdateSelfInfoUseCase implements UseCase<void, UpdateSelfInfoParams> {
  final ProfileRepository repository;

  UpdateSelfInfoUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateSelfInfoParams params) async {
    return await repository.updateSelfInfo(
      name: params.name,
      gender: params.gender,
      birthDate: params.birthDate,
      imageUrl: params.imageUrl,
    );
  }
}

class UpdateSelfInfoParams extends Equatable {
  final String? name;
  final String? gender;
  final String? birthDate;
  final String? imageUrl;

  const UpdateSelfInfoParams({
    this.name,
    this.gender,
    this.birthDate,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [name, gender, birthDate, imageUrl];
}
