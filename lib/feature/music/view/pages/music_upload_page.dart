import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vibe/core/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/widgets/adaptive_background.dart';
import 'package:vibe/feature/music/view/widgets/audio_upload.dart';
import 'package:vibe/feature/music/view/widgets/cover_image.dart';
import 'package:vibe/feature/music/view/widgets/song_details_form.dart';
import 'package:vibe/feature/music/view/widgets/tag_select.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Upload Track',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'SF Pro',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AdaptiveBackground(dominantColor: dominantColor),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.black.withValues(alpha: 0.15)),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: VibePadding.horizontalPadding,
                vertical: VibePadding.verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const CoverImageSection(),
                  const SizedBox(height: 20),
                  const AudioUploadSection(),
                  const SizedBox(height: 20),
                  UploadFormSection(
                    songNameController: songNameController,
                    artistNameController: artistNameController,
                  ),
                  const SizedBox(height: 24),
                  const TagSelectSection(),
                  const SizedBox(height: 28),
                  UploadButton(
                    songNameController: songNameController,
                    artistNameController: artistNameController,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
