import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/core/services/recently_played_service.dart';
import 'package:vibe/feature/home/model/song_model.dart';

part 'recently_played_provider.g.dart';

@riverpod
class RecentlyPlayed extends _$RecentlyPlayed {
  @override
  List<SongModel> build() {
    return RecentlyPlayedService.getRecentlyPlayed();
  }

  void addSong(SongModel song) async {
    await RecentlyPlayedService.addSong(song);
    state = RecentlyPlayedService.getRecentlyPlayed();
  }
}
