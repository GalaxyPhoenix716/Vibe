import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibe/core/theme/app_colors.dart';

class LyricsBottomSheet extends StatefulWidget {
  final String songName;
  final String artist;
  final Color dominantColor;

  const LyricsBottomSheet({
    super.key,
    required this.songName,
    required this.artist,
    required this.dominantColor,
  });

  @override
  State<LyricsBottomSheet> createState() => _LyricsBottomSheetState();
}

class _LyricsBottomSheetState extends State<LyricsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  double _collapsedHeight = 75.0;
  double _expandedHeight = 600.0;
  double _currentHeight = 75.0;

  bool _isAnimating = false;
  bool _isScrollingSheetDown = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heightAnimation = _animationController.drive(
      Tween<double>(
        begin: _collapsedHeight,
        end: _expandedHeight,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
    );
    _animationController.addListener(() {
      if (_isAnimating) {
        setState(() {
          _currentHeight = _heightAnimation.value;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    _collapsedHeight = 48.0 + bottomPadding;
    _expandedHeight = screenHeight * 0.90;

    // Set initial collapsed height
    if (!_isAnimating &&
        _animationController.status == AnimationStatus.dismissed) {
      _currentHeight = _collapsedHeight;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _animateTo(double targetHeight) {
    _isAnimating = true;
    final distance = (targetHeight - _currentHeight).abs();
    final totalRange = _expandedHeight - _collapsedHeight;

    // Dynamic duration (between 100ms and 300ms) based on distance
    final durationMs = totalRange > 0
        ? (300 * (distance / totalRange)).clamp(100.0, 300.0).toInt()
        : 300;

    _animationController.duration = Duration(milliseconds: durationMs);
    _heightAnimation = _animationController.drive(
      Tween<double>(
        begin: _currentHeight,
        end: targetHeight,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
    );

    _animationController.forward(from: 0.0).then((_) {
      _isAnimating = false;
      _currentHeight = targetHeight;
    });
  }

  void _snapSheet() {
    final threshold = (_collapsedHeight + _expandedHeight) / 2;
    if (_currentHeight > threshold) {
      _animateTo(_expandedHeight);
    } else {
      _animateTo(_collapsedHeight);
    }
  }

  void _toggleSheet() {
    if (_currentHeight > (_collapsedHeight + _expandedHeight) / 2) {
      _animateTo(_collapsedHeight);
    } else {
      _animateTo(_expandedHeight);
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isAnimating = false;
      _currentHeight = (_currentHeight - details.delta.dy).clamp(
        _collapsedHeight,
        _expandedHeight,
      );
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    // Snap based on position and drag velocity
    if (details.primaryVelocity != null &&
        details.primaryVelocity!.abs() > 300) {
      if (details.primaryVelocity! < 0) {
        _animateTo(_expandedHeight);
      } else {
        _animateTo(_collapsedHeight);
      }
    } else {
      _snapSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> lyrics = _getMockLyrics();
    final range = _expandedHeight - _collapsedHeight;
    final progress = range > 0
        ? ((_currentHeight - _collapsedHeight) / range).clamp(0.0, 1.0)
        : 0.0;

    final translateY = _expandedHeight - _currentHeight;

    return Positioned(
      bottom: -translateY,
      left: 0,
      right: 0,
      height: _expandedHeight,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: GestureDetector(
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: Colors.white.withValues(
                alpha: 0.35,
              ), // Translucent backing
              child: Stack(
                children: [
                  // 1. Collapsed UI (fades out as progress increases)
                  if (progress < 0.9)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: _collapsedHeight,
                      child: Opacity(
                        opacity: (1.0 - progress / 0.7).clamp(0.0, 1.0),
                        child: GestureDetector(
                          onTap: _toggleSheet,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            height: _collapsedHeight,
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom / 2,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.chevron_up,
                                  color: VibeColors.white,
                                  size: 16,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Swipe for music lyrics',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: VibeColors.white.withValues(
                                      alpha: 0.8,
                                    ),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  // 2. Expanded UI (slides up, with a very light header cross-fade for performance)
                  if (progress > 0.1)
                    Positioned.fill(
                      child: Column(
                        children: [
                          // Draggable Header Panel
                          Column(
                            children: [
                              const SizedBox(height: 12),
                              // Drag Handle
                              Container(
                                width: 40,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: VibeColors.white.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Opacity(
                                  // Fade only the text metadata header rather than the whole ListView
                                  opacity: ((progress - 0.1) / 0.7).clamp(
                                    0.0,
                                    1.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.songName.toUpperCase(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: 'SF Pro',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: VibeColors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              widget.artist,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'SF Pro',
                                                fontSize: 13,
                                                color: VibeColors.white
                                                    .withValues(alpha: 0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _animateTo(_collapsedHeight),
                                        icon: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: VibeColors.white.withValues(
                                              alpha: 0.1,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 18,
                                            color: VibeColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Scrollable Lyrics Content with dynamic drag interception
                          Expanded(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification notification) {
                                if (notification is ScrollUpdateNotification) {
                                  final dragDy =
                                      notification.dragDetails?.delta.dy;
                                  if (dragDy != null) {
                                    // Intercept if:
                                    // 1. Sheet is already partially collapsed
                                    // 2. Or we are at the top of the list and dragging down (dragDy > 0)
                                    if (_currentHeight < _expandedHeight ||
                                        (_scrollController.offset <= 0 &&
                                            dragDy > 0)) {
                                      setState(() {
                                        _isScrollingSheetDown = true;
                                        _isAnimating = false;
                                        _currentHeight =
                                            (_currentHeight - dragDy).clamp(
                                              _collapsedHeight,
                                              _expandedHeight,
                                            );
                                      });
                                      return true; // Consume scroll so list doesn't bounce
                                    }
                                  }
                                }
                                // When scroll drag releases, snap sheet back to correct position
                                if (notification is ScrollEndNotification) {
                                  if (_isScrollingSheetDown) {
                                    setState(() {
                                      _isScrollingSheetDown = false;
                                    });
                                  }
                                  if (_currentHeight < _expandedHeight &&
                                      !_isAnimating) {
                                    _snapSheet();
                                  }
                                }
                                return false;
                              },
                              child: ListView.builder(
                                controller: _scrollController,
                                physics:
                                    (_currentHeight == _expandedHeight ||
                                        _isScrollingSheetDown)
                                    ? const BouncingScrollPhysics()
                                    : const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  20,
                                  20,
                                  80,
                                ),
                                itemCount: lyrics.length,
                                itemBuilder: (context, index) {
                                  final isHighlighted = index == 3;

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                    ),
                                    child: Text(
                                      lyrics[index],
                                      style: TextStyle(
                                        fontFamily: 'SF Pro',
                                        fontSize: isHighlighted ? 26 : 22,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                        color: isHighlighted
                                            ? widget.dominantColor
                                            : VibeColors.white.withValues(
                                                alpha: 0.35,
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getMockLyrics() {
    if (widget.songName.toLowerCase().contains("africa")) {
      return [
        "I hear the drums echoing tonight",
        "But she hears only whispers of some quiet conversation",
        "She's coming in, 12:30 flight",
        "The moonlit wings reflect the stars that guide me towards salvation",
        "I stopped an old man along the way",
        "Hoping to find some old forgotten words or ancient melodies",
        "He turned to me as if to say,",
        "\"Hurry boy, it's waiting there for you\"",
        "It's gonna take a lot to drag me away from you",
        "There's nothing that a hundred men or more could ever do",
        "I bless the rains down in Africa",
        "Gonna take some time to do the things we never had",
        "The wild dogs cry out in the night",
        "As they grow restless, longing for some solitary company",
        "I know that I must do what's right",
        "As sure as Kilimanjaro rises like Olympus above the Serengeti",
        "I seek to cure what's deep inside",
        "Frightened of this thing that I've become",
      ];
    }

    return [
      "Running through the neon light",
      "We build our dreams inside the night",
      "Every beat is a step we take",
      "Every single promise that we make",
      "And the bass begins to rise",
      "Reflected in your starry eyes",
      "We are the rhythm, we are the song",
      "This is the place where we belong",
      "Hold on to the frequency",
      "Everything you wanted it to be",
      "Let the melody carry you home",
      "Underneath the sky, we are not alone",
      "Fade into the sweet release",
      "In the music, we find our peace",
      "So turn it up and feel the sound",
      "We've got both feet off the ground",
    ];
  }
}
