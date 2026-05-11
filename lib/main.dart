import 'package:flutter/material.dart';
import 'package:vibe/core/theme/theme.dart';
import 'package:vibe/feature/auth/view/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      home: const SignupPage(),
    );
  }
}

