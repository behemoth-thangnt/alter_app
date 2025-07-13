import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../data/datasources/profile_local_data_source.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_self_info_usecase.dart';
import '../../domain/usecases/update_self_info_usecase.dart';
import '../../../../core/usecases/usecase.dart';

part 'profile_providers.g.dart';

// Data Sources
@riverpod
ProfileRemoteDataSource profileRemoteDataSource(
    ProfileRemoteDataSourceRef ref) {
  return ProfileRemoteDataSourceImpl();
}

@riverpod
ProfileLocalDataSource profileLocalDataSource(ProfileLocalDataSourceRef ref) {
  return ProfileLocalDataSourceImpl();
}

// Repository
@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl(
    remoteDataSource: ref.watch(profileRemoteDataSourceProvider),
    localDataSource: ref.watch(profileLocalDataSourceProvider),
  );
}

// Use Cases
@riverpod
GetSelfInfoUseCase getSelfInfoUseCase(GetSelfInfoUseCaseRef ref) {
  return GetSelfInfoUseCase(ref.watch(profileRepositoryProvider));
}

@riverpod
UpdateSelfInfoUseCase updateSelfInfoUseCase(UpdateSelfInfoUseCaseRef ref) {
  return UpdateSelfInfoUseCase(ref.watch(profileRepositoryProvider));
}

// Profile State Management
@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Future<User?> build() async {
    // Auto-load profile on startup
    return await _loadProfile();
  }

  Future<User?> _loadProfile() async {
    final getSelfInfo = ref.read(getSelfInfoUseCaseProvider);
    final result = await getSelfInfo(const NoParams());

    return result.fold(
      (failure) => null,
      (user) => user,
    );
  }

  Future<void> loadProfile() async {
    state = const AsyncLoading();
    state = AsyncData(await _loadProfile());
  }

  Future<void> updateProfile({
    String? name,
    String? gender,
    String? birthDate,
    String? imageUrl,
  }) async {
    state = const AsyncLoading();

    final updateSelfInfo = ref.read(updateSelfInfoUseCaseProvider);
    final result = await updateSelfInfo(
      UpdateSelfInfoParams(
        name: name,
        gender: gender,
        birthDate: birthDate,
        imageUrl: imageUrl,
      ),
    );

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (_) async {
        // Reload profile after successful update
        state = AsyncData(await _loadProfile());
      },
    );
  }

  Future<void> refreshProfile() async {
    state = const AsyncLoading();
    state = AsyncData(await _loadProfile());
  }
}
