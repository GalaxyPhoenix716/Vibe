import 'package:flutter/material.dart';
import 'package:vibe/core/theme/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: VibeColors.backgroundColor,
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset('lib/core/icons/logo_transparent.png', height: 40),
      ),
      actions: [
        Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: VibeColors.card,
              child: Icon(
                Icons.multitrack_audio_rounded,
                color: VibeColors.white,
                size: 25,
              ),
            ),
            Positioned(
              right: 5,
              top: -4,
              child: CircleAvatar(
                radius: 29,
                backgroundColor: VibeColors.backgroundColor,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: VibeColors.deepBlue,
                ),
              ),
            ),
            const SizedBox(width: 100),
          ],
        ),
      ],
    );
  }
}
