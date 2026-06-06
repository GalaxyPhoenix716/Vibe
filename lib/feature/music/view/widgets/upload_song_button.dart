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

    final dominantColor = ref.watch(
      uploadViewModelProvider.select((state) => state.dominantColor),
    );

    final accentColor = (dominantColor == Colors.black || dominantColor.computeLuminance() < 0.05)
        ? VibeColors.brightPurple
        : dominantColor;

    final gradientColors = isUploading
        ? [
            Colors.white.withValues(alpha: 0.06),
            Colors.white.withValues(alpha: 0.02),
          ]
        : [
            accentColor,
            Color.lerp(accentColor, Colors.black, 0.25) ?? VibeColors.deepBlue,
          ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: isUploading
            ? []
            : [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 1,
                ),
              ],
        border: Border.all(
          color: isUploading
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.white.withValues(alpha: 0.15),
          width: 1.2,
        ),
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
                    message: e.toString().replaceAll('Exception: ', ''),
                    contentType: ContentType.failure,
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isUploading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Uploading...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: VibeColors.text.withValues(alpha: 0.7),
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ],
              )
            : Text(
                'Upload Song',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: VibeColors.text,
                  fontFamily: 'SF Pro',
                ),
              ),
      ),
    );
  }
}
