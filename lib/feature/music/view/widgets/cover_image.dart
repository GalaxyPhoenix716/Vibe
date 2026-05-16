import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/core/theme/app_colors.dart';
import '../../viewmodel/upload_viewmodel.dart';

class CoverImageSection extends ConsumerWidget {
  const CoverImageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverImage = ref.watch(
      uploadViewModelProvider.select((state) => state.coverImage),
    );

    return coverImage == null
        ? GestureDetector(
            onTap: () async {
              await ref
                  .read(uploadViewModelProvider.notifier)
                  .selectCoverImage();
            },

            child: Container(
              width: double.infinity,
              height:
                  MediaQuery.of(context).size.width -
                  (2 * VibePadding.horizontalPadding),

              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: VibeColors.card,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text('Upload Cover Image'),
            ),
          )
        : Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(coverImage.path),
                  width: double.infinity,
                  height:
                      MediaQuery.of(context).size.width -
                      (2 * VibePadding.horizontalPadding),
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(uploadViewModelProvider.notifier)
                            .selectCoverImage();
                      },
                      child: const Text('Change'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(uploadViewModelProvider.notifier)
                            .removeCoverImage();
                      },
                      child: const Text('Remove'),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
