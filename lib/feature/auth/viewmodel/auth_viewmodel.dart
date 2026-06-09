import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/core/providers/current_user_notifier.dart';
import '../../../core/models/user_model.dart';
import '../repositories/auth_repository.dart';
part 'auth_viewmodel.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late CurrentUserNotifier _currentUserNotifier;
  @override
  Future<UserModel?> build() async {
    final repository = ref.watch(authRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserProvider.notifier);

    if (!repository.isLoggedIn) {
      return null;
    }

    final user = await repository.fetchCurrentUser();
    _currentUserNotifier.addUser(user!);
    return user;
  }

  Future<void> loginWithGoogle() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signInWithGoogle();
    state = const AsyncLoading();
    state = await AsyncValue.guard(repository.fetchCurrentUser);
    final user = await repository.fetchCurrentUser();
    _currentUserNotifier.addUser(user!);
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
    state = const AsyncData(null);
  }
}
