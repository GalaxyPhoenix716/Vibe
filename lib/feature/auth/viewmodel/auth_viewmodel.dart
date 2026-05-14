import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vibe/feature/auth/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, Map<String, dynamic>?>((ref) {
      return AuthViewModel(ref.watch(authRepositoryProvider));
    });

class AuthViewModel extends StateNotifier<Map<String, dynamic>?> {
  final AuthRepository repository;

  AuthViewModel(this.repository) : super(null);

  bool get isLoggedIn => repository.isLoggedIn;

  Future<void> loginWithGoogle() async {
    await repository.signInWithGoogle();
    final user = await repository.loginToBackend();
    state = user;
  }

  Future<void> logout() async {
    await repository.signOut();
    state = null;
  }
}
