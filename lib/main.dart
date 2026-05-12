import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/services/supabase_service.dart';
import 'package:vibe/core/theme/theme.dart';
import 'package:vibe/feature/auth/view/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await SupabaseService.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      home: const AuthPage(),
    );
  }
}
