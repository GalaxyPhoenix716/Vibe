import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';
import '../../viewmodel/upload_viewmodel.dart';

class UploadFormSection extends ConsumerWidget {
  final TextEditingController songNameController;
  final TextEditingController artistNameController;

  const UploadFormSection({
    super.key,
    required this.songNameController,
    required this.artistNameController,
  });

  InputDecoration _decoration({
    required String hintText,
    required IconData icon,
    required Color activeColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, size: 22),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.04),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(
          color: activeColor.withValues(alpha: 0.7),
          width: 1.5,
        ),
      ),
      hintStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.45),
        fontSize: 15,
        fontFamily: 'SF Pro',
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dominantColor = ref.watch(
      uploadViewModelProvider.select((state) => state.dominantColor),
    );

    final activeColor = (dominantColor == Colors.black || dominantColor.computeLuminance() < 0.05)
        ? VibeColors.brightPurple
        : dominantColor;

    return Column(
      children: [
        // SONG NAME
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TextFormField(
            controller: songNameController,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'SF Pro',
            ),
            cursorColor: activeColor,
            decoration: _decoration(
              hintText: 'Song Name',
              icon: Icons.music_note_rounded,
              activeColor: activeColor,
            ),
          ),
        ),

        const SizedBox(height: 18),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TextFormField(
            controller: artistNameController,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'SF Pro',
            ),
            cursorColor: activeColor,
            decoration: _decoration(
              hintText: 'Artist Name',
              icon: Icons.person_rounded,
              activeColor: activeColor,
            ),
          ),
        ),
      ],
    );
  }
}
