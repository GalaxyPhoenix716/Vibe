import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/core/utils.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../viewmodel/upload_viewmodel.dart';

class UploadButton extends ConsumerWidget {
  final TextEditingController songNameController;
  final TextEditingController artistNameController;

  const UploadButton({
    super.key,
    required this.songNameController,
    required this.artistNameController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUploading = ref.watch(
      uploadViewModelProvider.select((state) => state.isUploading),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.18),
            Colors.white.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),

      child: ElevatedButton(
        onPressed: isUploading
            ? null
            : () async {
                try {
                  final message = await ref
                      .read(uploadViewModelProvider.notifier)
                      .uploadSong(
                        songName: songNameController.text,
                        artistName: artistNameController.text,
                        tags: ""  //TODO: add tags
                      );

                  if (!context.mounted) {
                    return;
                  }

                  showSnackbar(
                    context,
                    title: 'Success',
                    message: message,
                    contentType: ContentType.success,
                  );
                        ref.read(uploadViewModelProvider.notifier).resetState();
                  songNameController.clear();
                  artistNameController.clear();
                  
                } catch (e) {
                  if (!context.mounted) {
                    return;
                  }

                  showSnackbar(
                    context,
                    title: 'Upload Failed',
                    message: e.toString(),
                    contentType: ContentType.failure,
                  );
                }
              },

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),

        child: isUploading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.4),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Uploading...',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: VibeColors.text,
                    ),
                  ),
                ],
              )
            : Text(
                'Upload Song',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: VibeColors.text,
                ),
              ),
      ),
    );
  }
}
