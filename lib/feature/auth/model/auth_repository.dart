import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<void> signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: dotenv.env['SUPABASE_CALLBACK_URL'],
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Session? get session => supabase.auth.currentSession;

  bool get isLoggedIn => session != null;
}