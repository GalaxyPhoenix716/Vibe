import 'package:cached_network_image/cached_network_image.dart';
import 'package:coverflow_carousel/coverflow_carousel.dart';
import 'package:flutter/material.dart';
import 'package:vibe/feature/home/model/playlist_model.dart';
import 'package:vibe/feature/home/model/song_model.dart';

class PlaylistCarousel extends StatefulWidget {
  final List<SongModel> songs;
  const PlaylistCarousel({super.key, required this.songs});

  @override
  State<PlaylistCarousel> createState() => _PlaylistCarouselState();
}

class _PlaylistCarouselState extends State<PlaylistCarousel> {
  @override
  Widget build(BuildContext context) {
    final playlist = PlaylistModel.generatePlaylists(widget.songs);

    if (widget.songs.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 200,
      child: CoverflowCarousel.builder(
        itemCount: playlist.length,
        itemWidth: 180,
        itemHeight: 180,
        initialPage: playlist.length ~/ 2,
        nearCardSpacing: 50,
        farCardSpacing: 60,
        visibleItems: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: ClipOval(
              child: Image.asset(
                playlist[index].playlistThumbnail,
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
