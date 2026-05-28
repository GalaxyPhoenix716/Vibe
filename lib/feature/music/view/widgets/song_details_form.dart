import 'package:flutter/material.dart';

class UploadFormSection extends StatelessWidget {
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
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, size: 22),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.08),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      hintStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.55),
        fontSize: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SONG NAME
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextFormField(
            controller: songNameController,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: _decoration(
              hintText: 'Song Name',
              icon: Icons.music_note_rounded,
            ),
          ),
        ),

        const SizedBox(height: 18),

        // ARTIST NAME
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: TextFormField(
            controller: artistNameController,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: _decoration(
              hintText: 'Artist Name',
              icon: Icons.person_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
