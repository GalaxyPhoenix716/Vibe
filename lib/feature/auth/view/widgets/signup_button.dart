import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vibe/core/theme/app_colors.dart';
import '../../viewmodel/auth_viewmodel.dart';

class SignUpButton extends ConsumerWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          colors: [VibeColors.deepBlue, VibeColors.brightPurple],
        ),
      ),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(295, 55),

          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () async {
          await ref.read(authViewModelProvider.notifier).loginWithGoogle();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.google, color: VibeColors.white),

              const SizedBox(width: 15),

              Text(
                "Sign Up with Google",
                style: TextStyle(fontSize: 18, color: VibeColors.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
