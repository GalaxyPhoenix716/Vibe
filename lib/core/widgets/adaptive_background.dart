import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';

class AdaptiveBackground extends ConsumerWidget {
  const AdaptiveBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [VibeColors.backgroundColor]),
      ),
    );
  }
}