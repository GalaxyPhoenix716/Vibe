import 'package:flutter_riverpod/legacy.dart';
import '../model/auth_repository.dart';

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
