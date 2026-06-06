import 'package:coverflow_carousel/coverflow_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/feature/home/viewmodel/home_viewmodel.dart';

class PlaylistCarousel extends ConsumerStatefulWidget {
  const PlaylistCarousel({super.key});

  @override
  ConsumerState<PlaylistCarousel> createState() => _PlaylistCarouselState();
}

class _PlaylistCarouselState extends ConsumerState<PlaylistCarousel> {
  int? _currentIndex;

  @override
  Widget build(BuildContext context) {
    final playlists = ref.watch(dynamicPlaylistsProvider);

    if (playlists.isEmpty) {
      return const SizedBox.shrink();
    }

    final initialPage = playlists.length ~/ 2;
    final activeIndex = _currentIndex ?? initialPage;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: CoverflowCarousel.builder(
            itemCount: playlists.length,
            itemWidth: 180,
            itemHeight: 180,
            initialPage: initialPage,
            nearCardSpacing: 50,
            farCardSpacing: 60,
            visibleItems: 2,
            entryAnimation: CoverflowEntryAnimation.spacingExpand,
            entryAnimationDuration: const Duration(milliseconds: 1000),
            entryAnimationCurve: Curves.easeOutBack,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: ClipOval(
                  child: Image.asset(
                    playlists[index].playlistThumbnail,
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Column(
            key: ValueKey<int>(activeIndex),
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                playlists[activeIndex].name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: VibeColors.white,
                  fontFamily: 'SF Pro',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                playlists[activeIndex].description,
                style: const TextStyle(
                  fontSize: 14,
                  color: VibeColors.greyText,
                  fontFamily: 'SF Pro',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
