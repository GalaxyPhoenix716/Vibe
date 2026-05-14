import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/view/pages/home_page.dart';
import '../../viewmodel/auth_viewmodel.dart';
import 'auth_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        }

        return const AuthPage();
      },

      loading: () {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },

      error: (error, stackTrace) {
        return Scaffold(body: Center(child: Text(error.toString())));
      },
    );
  }
}
