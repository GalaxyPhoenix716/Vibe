import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/core/widgets/home_appbar.dart';
import 'package:vibe/feature/music/viewmodel/upload_viewmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: VibeColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const HomeAppBar(),
          SliverFillRemaining(
            child: ref.watch(getAllFavSongsProvider).when(
              data: (data) {
                return Container();
              },
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: VibeColors.error),
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(VibeColors.brightPurple),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
