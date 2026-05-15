import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/utils.dart';
import '../../../home/view/pages/home_page.dart';
import '../../viewmodel/auth_viewmodel.dart';
import 'auth_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authViewModelProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          showSnackbar(
            context,
            title: "Authentication Failed",
            message: error.toString(),
            contentType: ContentType.failure,
          );
        },
      );
    });

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
        return const AuthPage();
      },
    );
  }
}
