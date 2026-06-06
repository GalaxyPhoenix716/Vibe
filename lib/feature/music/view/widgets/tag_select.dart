import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';
import '../../viewmodel/upload_viewmodel.dart';

class TagSelectSection extends ConsumerWidget {
  const TagSelectSection({super.key});

  static const tags = [
    'Pop',
    'Rock',
    'Hip-Hop',
    'EDM',
    'Jazz',
    'Classical',
    'Chill',
    'Workout',
    'Study',
    'Party',
    'Travel',
    'Sleep',
    'Focus',
    'Hindi',
    'English',
    'Punjabi',
    'Tamil',
    'Telugu',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTags = ref.watch(
      uploadViewModelProvider.select((state) => state.selectedTags),
    );

    final dominantColor = ref.watch(
      uploadViewModelProvider.select((state) => state.dominantColor),
    );

    final accentColor = (dominantColor == Colors.black || dominantColor.computeLuminance() < 0.05)
        ? VibeColors.brightPurple
        : dominantColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tags',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontFamily: 'SF Pro',
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: tags.map((tag) {
            final isSelected = selectedTags.contains(tag);

            return GestureDetector(
              onTap: () {
                ref.read(uploadViewModelProvider.notifier).toggleTag(tag);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            accentColor.withValues(alpha: 0.25),
                            accentColor.withValues(alpha: 0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected
                      ? null
                      : Colors.white.withValues(alpha: 0.04),
                  border: Border.all(
                    color: isSelected
                      ? accentColor.withValues(alpha: 0.45)
                      : Colors.white.withValues(alpha: 0.06),
                    width: 1.2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            blurRadius: 15,
                            color: accentColor.withValues(alpha: 0.12),
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: accentColor,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      tag,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.white70,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
