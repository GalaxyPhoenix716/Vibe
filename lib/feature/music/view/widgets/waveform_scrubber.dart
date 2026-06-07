import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/providers/current_song_notifier.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/feature/home/model/song_model.dart';

class WaveformScrubber extends ConsumerStatefulWidget {
  final SongModel song;
  final Color activeColor;
  final bool isPlaying;

  const WaveformScrubber({
    super.key,
    required this.song,
    required this.activeColor,
    required this.isPlaying,
  });

  @override
  ConsumerState<WaveformScrubber> createState() => _WaveformScrubberState();
}

class _WaveformScrubberState extends ConsumerState<WaveformScrubber>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<double> _baseHeights;
  static const int _barCount = 45;
  double? _dragProgress;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _generateHeights();
    _updateAnimationState();
  }

  @override
  void didUpdateWidget(covariant WaveformScrubber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.song.id != widget.song.id) {
      _generateHeights();
    }
    _updateAnimationState();
  }

  void _generateHeights() {
    final random = Random(widget.song.id.hashCode);
    _baseHeights = List.generate(_barCount, (index) {
      // Generate a random-looking wave shape, scaled with a sine wave
      // to taper it towards both ends for a clean audio aesthetic.
      final randVal = 0.25 + random.nextDouble() * 0.55;
      final progress = index / (_barCount - 1);
      final sineScale = sin(progress * pi);
      return (randVal * sineScale) * 55 + 10; // Height between 10 and 65
    });
  }

  void _updateAnimationState() {
    if (widget.isPlaying) {
      if (!_animationController.isAnimating) {
        _animationController.repeat();
      }
    } else {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSeek(double localDx, double totalWidth) {
    if (totalWidth <= 0) return;
    double progress = localDx / totalWidth;
    progress = progress.clamp(0.0, 1.0);
    setState(() {
      _dragProgress = progress;
    });
  }

  void _seekToProgress(double progress, Duration duration) {
    final target = duration * progress;
    ref.read(audioPlayerInstanceProvider).seek(target);
    setState(() {
      _dragProgress = null;
    });
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final positionAsync = ref.watch(currentSongPositionProvider);
    final durationAsync = ref.watch(currentSongDurationProvider);

    final position = positionAsync.value ?? Duration.zero;
    final duration = durationAsync.value ?? Duration.zero;

    final currentProgress =
        _dragProgress ??
        (duration.inMilliseconds > 0
            ? position.inMilliseconds / duration.inMilliseconds
            : 0.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            return GestureDetector(
              onHorizontalDragStart: (details) {
                _handleSeek(details.localPosition.dx, totalWidth);
              },
              onHorizontalDragUpdate: (details) {
                _handleSeek(details.localPosition.dx, totalWidth);
              },
              onHorizontalDragEnd: (details) {
                if (_dragProgress != null) {
                  _seekToProgress(_dragProgress!, duration);
                }
              },
              onTapDown: (details) {
                _handleSeek(details.localPosition.dx, totalWidth);
              },
              onTapUp: (details) {
                if (_dragProgress != null) {
                  _seekToProgress(_dragProgress!, duration);
                }
              },
              child: Container(
                height: 80,
                width: double.infinity,
                color: Colors.transparent,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(_barCount, (index) {
                        final barProgress = index / (_barCount - 1);
                        final isFilled = barProgress <= currentProgress;

                        // Calculate height fluctuation if playing
                        double animatedHeight = _baseHeights[index];
                        if (widget.isPlaying) {
                          final waveOffset = index * 0.4;
                          final animationFactor = sin(
                            _animationController.value * 2 * pi + waveOffset,
                          );
                          // Gentle 20% vertical bobbing animation
                          animatedHeight =
                              _baseHeights[index] *
                              (1.0 + 0.20 * animationFactor);
                        }

                        return Container(
                          width: 4,
                          height: animatedHeight,
                          decoration: BoxDecoration(
                            color: isFilled
                                ? widget.activeColor
                                : VibeColors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            );
          },
        ),
        // Time Indicators Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(
                  _dragProgress != null ? duration * _dragProgress! : position,
                ),
                style: TextStyle(
                  color: VibeColors.white.withValues(alpha: 0.6),
                  fontFamily: 'SF Pro',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _formatDuration(duration),
                style: TextStyle(
                  color: VibeColors.white.withValues(alpha: 0.6),
                  fontFamily: 'SF Pro',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
