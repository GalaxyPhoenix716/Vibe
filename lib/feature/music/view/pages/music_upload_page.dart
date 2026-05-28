import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vibe/core/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/widgets/adaptive_background.dart';
import 'package:vibe/feature/music/view/widgets/audio_upload.dart';
import 'package:vibe/feature/music/view/widgets/cover_image.dart';
import 'package:vibe/feature/music/view/widgets/song_details_form.dart';
import 'package:vibe/feature/music/view/widgets/upload_song_button.dart';
import 'package:vibe/feature/music/viewmodel/upload_viewmodel.dart';

class MusicUploadPage extends ConsumerStatefulWidget {
  const MusicUploadPage({super.key});

  @override
  ConsumerState<MusicUploadPage> createState() => _MusicUploadPageState();
}

class _MusicUploadPageState extends ConsumerState<MusicUploadPage> {
  late final TextEditingController songNameController;
  late final TextEditingController artistNameController;

  @override
  void initState() {
    super.initState();
    songNameController = TextEditingController();
    artistNameController = TextEditingController();
  }

  @override
  void dispose() {
    songNameController.dispose();
    artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dominantColor = ref.watch(
      uploadViewModelProvider.select((state) => state.dominantColor),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //Background Gradient
            AdaptiveBackground(dominantColor: dominantColor),

            //Background Blur
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.black.withValues(alpha: 0.1)),
            ),

            //Main widgets
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: VibePadding.horizontalPadding,
                  vertical: VibePadding.verticalPadding,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CoverImageSection(),
                      const SizedBox(height: 15),
                      AudioUploadSection(),
                      const SizedBox(height: 15),
                      UploadFormSection(
                        songNameController: songNameController,
                        artistNameController: artistNameController,
                      ),
                      const SizedBox(height: 15),
                      UploadButton(
                        songNameController: songNameController,
                        artistNameController: artistNameController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
