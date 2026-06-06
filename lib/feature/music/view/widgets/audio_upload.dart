import 'dart:ui';
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
  PlayerController? _playerController;
  bool _isWaveformReady = false;
  String? _currentPath;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
  }

  @override
  void dispose() {
    _playerController?.dispose();
    super.dispose();
  }

  Future<void> _prepareWaveform(String path) async {
    if (_currentPath == path) {
      return;
    }

    _currentPath = path;
    _isWaveformReady = false;

    final oldController = _playerController;
    
    final newController = PlayerController();
    _playerController = newController;

    if (mounted) {
      setState(() {});
    }

    if (oldController != null) {
      oldController.dispose();
    }

    await newController.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
    );

    if (_playerController == newController) {
      _isWaveformReady = true;
      if (mounted) {
        setState(() {});
      }
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

    final dominantColor = ref.watch(
      uploadViewModelProvider.select((state) => state.dominantColor),
    );

    final accentColor = (dominantColor == Colors.black || dominantColor.computeLuminance() < 0.05)
        ? VibeColors.brightPurple
        : dominantColor;

    if (audioFile == null) {
      if (_currentPath != null) {
        _currentPath = null;
        _isWaveformReady = false;
        _playerController?.dispose();
        _playerController = null;
      }

      return GestureDetector(
        onTap: () async {
          await ref.read(uploadViewModelProvider.notifier).selectAudioFile();
        },
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: 20,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.audiotrack_rounded,
                    size: 32,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Upload Audio Track',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'SF Pro',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supports MP3, M4A, WAV',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.5),
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    _prepareWaveform(audioFile.path);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.music_note_rounded,
                  size: 26,
                  color: accentColor,
                ),
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
                        fontFamily: 'SF Pro',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      audioDuration != null
                          ? formatDuration(audioDuration)
                          : '--:--',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.65),
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
  
          if (_isWaveformReady)
            AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width - 80, 70),
              playerController: _playerController!,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: PlayerWaveStyle(
                fixedWaveColor: Colors.white.withValues(alpha: 0.18),
                liveWaveColor: accentColor,
              ),
              enableSeekGesture: false,
            )
          else
            SizedBox(
              height: 70,
              child: Center(
                child: CircularProgressIndicator(
                  color: accentColor,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          const SizedBox(height: 20),
  
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(uploadViewModelProvider.notifier)
                        .selectAudioFile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF Pro',
                    ),
                  ),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withValues(alpha: 0.08),
                    foregroundColor: Colors.redAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: Colors.redAccent.withValues(alpha: 0.15),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.borderRadius = 28.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    double distance = 0.0;
    for (final PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        dashPath.addPath(
          measurePath.extractPath(distance, distance + dashLength),
          Offset.zero,
        );
        distance += dashLength + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

