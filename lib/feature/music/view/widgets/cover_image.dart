import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/upload_viewmodel.dart';

class CoverImageSection extends ConsumerWidget {
  const CoverImageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverImage = ref.watch(
      uploadViewModelProvider.select((state) => state.coverImage),
    );

    // NO IMAGE SELECTED
    if (coverImage == null) {
      return GestureDetector(
        onTap: () async {
          await ref.read(uploadViewModelProvider.notifier).selectCoverImage();
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1.5,
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image_rounded, size: 42),
              ),

              const SizedBox(height: 18),

              const Text(
                'Upload Cover Image',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              Text(
                'PNG, JPG, JPEG',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // IMAGE SELECTED

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Column(
        key: ValueKey(coverImage.path),
        children: [
          // IMAGE
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 25,
                  offset: const Offset(0, 15),
                ),
              ],

              image: DecorationImage(
                image: FileImage(File(coverImage.path)),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await ref
                        .read(uploadViewModelProvider.notifier)
                        .selectCoverImage();
                  },
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Change'),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ref
                        .read(uploadViewModelProvider.notifier)
                        .removeCoverImage();
                  },
                  icon: const Icon(Icons.delete_rounded),
                  label: const Text('Remove'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
