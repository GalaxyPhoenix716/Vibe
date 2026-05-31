import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tags',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 18),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: tags.map((tag) {
            final isSelected = selectedTags.contains(tag);

            return GestureDetector(
              onTap: () {
                ref.read(uploadViewModelProvider.notifier).toggleTag(tag);
              },

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),

                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),

                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.22),
                            Colors.white.withValues(alpha: 0.12),
                          ],
                        )
                      : null,

                  color: isSelected
                      ? null
                      : Colors.white.withValues(alpha: 0.05),

                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.35)
                        : Colors.white.withValues(alpha: 0.08),
                  ),

                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ]
                      : [],
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(Icons.check_rounded, size: 16),
                      const SizedBox(width: 6),
                    ],

                    Text(
                      tag,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.white70,
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
