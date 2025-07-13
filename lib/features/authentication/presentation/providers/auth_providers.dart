import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/get_current_profile_usecase.dart';
import '../../../../core/usecases/usecase.dart';

part 'auth_providers.g.dart';

// Data Sources
@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  return AuthRemoteDataSourceImpl();
}

@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  return AuthLocalDataSourceImpl(
    secureStorage: ref.watch(secureStorageProvider),
  );
}

// Repository
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
}

// Use Cases
@riverpod
SignInUseCase signInUseCase(SignInUseCaseRef ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignOutUseCase signOutUseCase(SignOutUseCaseRef ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GetCurrentProfileUseCase getCurrentProfileUseCase(
    GetCurrentProfileUseCaseRef ref) {
  return GetCurrentProfileUseCase(ref.watch(authRepositoryProvider));
}

// Auth State Management
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthProfile?> build() async {
    // Check current authentication status on startup
    final getCurrentProfile = ref.read(getCurrentProfileUseCaseProvider);
    final result = await getCurrentProfile(const NoParams());

    return result.fold(
      (failure) => null,
      (profile) => profile,
    );
  }

  Future<void> signIn({
    required String identifier,
    required String password,
  }) async {
    // Set loading state
    state = const AsyncLoading();

    final signInUseCase = ref.read(signInUseCaseProvider);
    final result = await signInUseCase(
      SignInParams(identifier: identifier, password: password),
    );

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (profile) {
        state = AsyncData(profile);
      },
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();

    final signOutUseCase = ref.read(signOutUseCaseProvider);
    final result = await signOutUseCase(const NoParams());

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (_) {
        state = const AsyncData(null);
      },
    );
  }

  Future<void> checkAuthStatus() async {
    final getCurrentProfile = ref.read(getCurrentProfileUseCaseProvider);
    final result = await getCurrentProfile(const NoParams());

    result.fold(
      (failure) {
        state = const AsyncData(null);
      },
      (profile) {
        state = AsyncData(profile);
      },
    );
  }
}
