import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/providers/current_song_notifier.dart';
import 'package:vibe/core/theme/app_colors.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final currentSongColorAsync = ref.watch(currentSongColorProvider);

    if (currentSong == null) {
      return const SizedBox();
    }

    return Stack(
      children: [
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(8),
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
                  SizedBox(
                    // height: 62,
                    // width: 62,
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
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        currentSong.artist,
                        style: TextStyle(fontFamily: 'SF Pro', fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(CupertinoIcons.heart),
                  const SizedBox(width: 20),
                  Icon(CupertinoIcons.play_arrow_solid),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
