import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibe/feature/music/viewmodel/upload_viewmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getAllFavSongsProvider)
        .when(
          data: (data) {
            return Container();
          },
          error: ((error, stackTrace) {
            return Center(child: Text(error.toString()));
          }),
          loading: () => const CircularProgressIndicator.adaptive(),
        );
  }
}
