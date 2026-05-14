import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/api_service.dart';
import '../model/user_model.dart';

class AuthRepository {
  AuthRepository();

  final supabase = Supabase.instance.client;

  Future<void> signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kIsWeb ? null : 'io.supabase.flutter://login-callback/',
    );
  }

  Future<UserModel?> fetchCurrentUser() async {
    final token = supabase.auth.currentSession?.accessToken;

    if (token == null) {
      return null;
    }

    final response = await ApiService.login(token);

    return UserModel.fromJson(response['user']);
  }

  bool get isLoggedIn => supabase.auth.currentSession != null;

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
