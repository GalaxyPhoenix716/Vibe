import 'package:audio_waveforms/audio_waveforms.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vibe/core/theme/app_colors.dart';

import '../../viewmodel/upload_viewmodel.dart';

class AudioUploadSection extends ConsumerStatefulWidget {
  const AudioUploadSection({super.key});

  @override
  ConsumerState<AudioUploadSection> createState() => _AudioUploadSectionState();
}

class _AudioUploadSectionState extends ConsumerState<AudioUploadSection> {
  late final PlayerController _playerController;
  bool _isWaveformReady = false;
  String? _currentPath;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Future<void> _prepareWaveform(String path) async {
    if (_currentPath == path) {
      return;
    }

    _currentPath = path;
    _isWaveformReady = false;

    if (mounted) {
      setState(() {});
    }

    await _playerController.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
    );

    _isWaveformReady = true;

    if (mounted) {
      setState(() {});
    }
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final audioFile = ref.watch(
      uploadViewModelProvider.select((state) => state.audioFile),
    );

    final audioDuration = ref.watch(
      uploadViewModelProvider.select((state) => state.audioDuration),
    );

    // NO AUDIO SELECTED

    if (audioFile == null) {
      _currentPath = null;

      return GestureDetector(
        onTap: () async {
          await ref.read(uploadViewModelProvider.notifier).selectAudioFile();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: VibeColors.card.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            children: [
              Icon(Icons.audio_file_rounded, size: 38),

              SizedBox(height: 12),

              Text(
                'Upload MP3 File',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    // PREPARE WAVEFORM
    _prepareWaveform(audioFile.path);

    // AUDIO CARD
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FILE INFO
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.music_note_rounded, size: 28),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audioFile.path.split('/').last,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      audioDuration != null
                          ? formatDuration(audioDuration)
                          : '--:--',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // WAVEFORM
          if (_isWaveformReady)
            AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width - 80, 70),
              playerController: _playerController,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: PlayerWaveStyle(
                fixedWaveColor: Colors.white.withValues(alpha: 0.35),
                liveWaveColor: Colors.white,
              ),
              enableSeekGesture: false,
            )
          else
            const SizedBox(
              height: 70,
              child: Center(child: CircularProgressIndicator()),
            ),

          const SizedBox(height: 20),

          // ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(uploadViewModelProvider.notifier)
                        .selectAudioFile();
                  },
                  child: const Text('Change'),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(uploadViewModelProvider.notifier)
                        .removeAudioFile();
                  },
                  child: const Text('Remove'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
