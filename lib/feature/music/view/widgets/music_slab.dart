import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/providers/current_song_notifier.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/feature/music/view/pages/music_player.dart';
import 'package:vibe/feature/music/view/widgets/player_route_transition.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final currentSongColorAsync = ref.watch(currentSongColorProvider);
    final isPlayingAsync = ref.watch(isPlayingProvider);
    final isPlaying = isPlayingAsync.value ?? false;
    final durationAsync = ref.watch(currentSongDurationProvider);

    final duration = durationAsync.value ?? Duration.zero;

    if (currentSong == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(PlayerRouteTransition(child: const MusicPlayer()));
            },
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: currentSongColorAsync.value ?? VibeColors.pink,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'music-player-art-${currentSong.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: currentSong.thumbnail_url,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentSong.song_name,
                            style: const TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            currentSong.artist,
                            style: const TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart),
                        color: VibeColors.white,
                      ),
                      const SizedBox(width: 5),
                      IconButton(
                        onPressed: () {
                          ref.read(currentSongProvider.notifier).playPause();
                        },
                        icon: isPlaying
                            ? const Icon(CupertinoIcons.pause_fill)
                            : const Icon(CupertinoIcons.play_arrow_solid),
                        color: VibeColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 13,
            child: ClipRRect(
              child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width - 42,
                decoration: BoxDecoration(
                  color: VibeColors.inactive.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 13,
            child: StreamBuilder<Duration>(
              stream: ref.watch(audioPlayerInstanceProvider).positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final double progress = duration.inMilliseconds > 0
                    ? position.inMilliseconds / duration.inMilliseconds
                    : 0.0;

                return ClipRRect(
                  child: Container(
                    height: 3,
                    width: (MediaQuery.of(context).size.width - 42) * progress,
                    decoration: BoxDecoration(
                      color: VibeColors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
