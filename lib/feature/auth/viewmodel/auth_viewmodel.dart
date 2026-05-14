import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/user_model.dart';
import '../repositories/auth_repository.dart';
part 'auth_viewmodel.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  Future<UserModel?> build() async {
    final repository = ref.read(authRepositoryProvider);

    if (!repository.isLoggedIn) {
      return null;
    }

    return repository.fetchCurrentUser();
  }

  Future<void> loginWithGoogle() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signInWithGoogle();
    state = const AsyncLoading();
    state = await AsyncValue.guard(repository.fetchCurrentUser);
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
    state = const AsyncData(null);
  }
}
