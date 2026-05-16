import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';

class AdaptiveBackground extends ConsumerWidget {
  final Color dominantColor;
  const AdaptiveBackground({super.key, required this.dominantColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned.fill(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [VibeColors.backgroundColor, dominantColor.withValues(alpha: 0.4), dominantColor.withValues(alpha: 0.6), dominantColor.withValues(alpha: 0.8)],
          ),
        ),
      ),
    );
  }
}
