import 'dart:developer' as dev;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coverflow_carousel/coverflow_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/providers/current_song_notifier.dart';
import 'package:vibe/feature/home/model/song_model.dart';

class MusicMixCarousel extends ConsumerStatefulWidget {
  final List<SongModel> songs;

  const MusicMixCarousel({super.key, required this.songs});

  @override
  ConsumerState<MusicMixCarousel> createState() => _MusicMixCarouselState();
}

class _MusicMixCarouselState extends ConsumerState<MusicMixCarousel> {
  @override
  Widget build(BuildContext context) {
    if (widget.songs.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 200,
      child: CoverflowCarousel.builder(
        itemCount: widget.songs.length,
        itemWidth: 180,
        itemHeight: 180,
        initialPage: widget.songs.length ~/ 2,
        nearCardSpacing: 40,
        farCardSpacing: 45,
        entryAnimation: CoverflowEntryAnimation.spacingExpand,
        entryAnimationDuration: const Duration(milliseconds: 1000),
        entryAnimationCurve: Curves.easeOutBack,
        itemBuilder: (context, index) {
          final song = widget.songs[index];
          return GestureDetector(
            onTap: () {
              dev.log("tapped");
              ref.read(currentSongProvider.notifier).updateSong(song);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl: song.thumbnail_url,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
