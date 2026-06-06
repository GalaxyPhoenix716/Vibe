import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';
import '../../viewmodel/upload_viewmodel.dart';

class CoverImageSection extends ConsumerWidget {
  const CoverImageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverImage = ref.watch(
      uploadViewModelProvider.select((state) => state.coverImage),
    );

    final dominantColor = ref.watch(
      uploadViewModelProvider.select((state) => state.dominantColor),
    );

    if (coverImage == null) {
      return GestureDetector(
        onTap: () async {
          await ref.read(uploadViewModelProvider.notifier).selectCoverImage();
        },
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: 28,
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.image_rounded,
                    size: 42,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Upload Cover Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'SF Pro',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'PNG, JPG, JPEG',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.55),
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Stack(
        key: ValueKey(coverImage.path),
        children: [
          // IMAGE CONTAINER WITH GLOW
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: (dominantColor == Colors.black || dominantColor.computeLuminance() < 0.05)
                      ? VibeColors.deepBlue.withValues(alpha: 0.15)
                      : dominantColor.withValues(alpha: 0.25),
                  blurRadius: 35,
                  offset: const Offset(0, 15),
                  spreadRadius: 2,
                ),
              ],
              image: DecorationImage(
                image: FileImage(File(coverImage.path)),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 15,
            right: 15,
            child: Row(
              children: [
                _GlassActionButton(
                  icon: Icons.edit_rounded,
                  tooltip: 'Change Cover',
                  onPressed: () async {
                    await ref
                        .read(uploadViewModelProvider.notifier)
                        .selectCoverImage();
                  },
                ),
                const SizedBox(width: 10),
                _GlassActionButton(
                  icon: Icons.delete_rounded,
                  tooltip: 'Remove Cover',
                  color: Colors.redAccent.withValues(alpha: 0.85),
                  onPressed: () {
                    ref
                        .read(uploadViewModelProvider.notifier)
                        .removeCoverImage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final String tooltip;

  const _GlassActionButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                  width: 1.2,
                ),
              ),
              child: Icon(
                icon,
                size: 20,
                color: color ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.borderRadius = 28.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    double distance = 0.0;
    for (final PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        dashPath.addPath(
          measurePath.extractPath(distance, distance + dashLength),
          Offset.zero,
        );
        distance += dashLength + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

