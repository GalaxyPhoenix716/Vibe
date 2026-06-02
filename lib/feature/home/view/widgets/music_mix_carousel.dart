import 'dart:developer' as dev;
import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vibe/core/utils.dart';
import 'package:vibe/feature/home/model/song_model.dart';
import 'package:vibe/feature/home/view/widgets/overllaped_carousel/overllaped_carousel.dart';

class MusicMixCarousel extends StatefulWidget {
  final List<SongModel> songs;

  const MusicMixCarousel({super.key, required this.songs});

  @override
  State<MusicMixCarousel> createState() => _MusicMixCarouselState();
}

class _MusicMixCarouselState extends State<MusicMixCarousel> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.48);
    _controller.addListener(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.songs.isEmpty) {
      return const SizedBox.shrink();
    }

    dev.log(widget.songs.toString());

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: min(screenWidth / 1.6, screenHeight * .9),
        child: OverlappedCarousel.builder(
          itemCount: widget.songs.length,
          itemWidth: 200,
          itemHeight: 200,
          initialPage: widget.songs.length ~/ 2,
          onPageChanged: (index) {
            debugPrint(widget.songs[index].song_name);
          },

          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                imageUrl: widget.songs[index].thumbnail_url,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
