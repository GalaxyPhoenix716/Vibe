import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/feature/home/model/playlist_model.dart';
import 'package:vibe/feature/music/viewmodel/upload_viewmodel.dart';

part 'home_viewmodel.g.dart';

@riverpod
List<PlaylistModel> dynamicPlaylists(Ref ref) {
  final songsAsync = ref.watch(getAllSongsProvider);
  return songsAsync.maybeWhen(
    data: (songs) => PlaylistModel.generatePlaylists(songs),
    orElse: () => [],
  );
}
