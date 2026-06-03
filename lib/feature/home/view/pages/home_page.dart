import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/feature/home/view/widgets/home_appbar.dart';
import 'package:vibe/feature/home/view/widgets/music_mix_carousel.dart';
import 'package:vibe/feature/home/view/widgets/user_header.dart';
import 'package:vibe/feature/music/viewmodel/upload_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsList = ref.watch(getAllSongsProvider);

    return SafeArea(
      child: Scaffold(
        body: songsList.when(
          data: (songs) {
            return CustomScrollView(
              slivers: [
                HomeAppBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: VibePadding.horizontalPadding,
                  ),
                  child: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        UserHeader(userName: 'Mudit'),
                        MusicMixCarousel(songs: songs),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
