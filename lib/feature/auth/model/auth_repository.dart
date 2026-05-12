import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/services/api_service.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<void> signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback/',
    );
  }

  Future<Map<String, dynamic>?> loginToBackend() async {
    final token = supabase.auth.currentSession?.accessToken;

    if (token == null) return null;

    return await ApiService.login(token);
  }

  bool get isLoggedIn => supabase.auth.currentSession != null;

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
