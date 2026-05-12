import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repositories/auth_repository.dart';
import '../viewmodel/auth_viewmodel.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, Map<String, dynamic>?>((ref) {
      return AuthViewModel(ref.watch(authRepositoryProvider));
    });
