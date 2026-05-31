import 'package:vibe/feature/home/model/song_model.dart';

class PlaylistModel {
  final String name;
  final String description;
  final List<SongModel> songs;

  PlaylistModel({
    required this.name,
    required this.description,
    required this.songs,
  });

  List<PlaylistModel> generatePlaylists(List<SongModel> songs) {
    if (songs.isEmpty) {
      return [];
    }

    final playlistInfo = [
      ('Trending Now', 'Most played tracks'),
      ('Fresh Uploads', 'Recently added music'),
      ('Late Night Vibes', 'Perfect for the night'),
      ('Workout Mix', 'High energy tracks'),
      ('Chill Session', 'Relax and unwind'),
      ('Road Trip', 'Music for the journey'),
      ('Daily Mix', 'Handpicked for you'),
      ('Hidden Gems', 'Discover something new'),
    ];

    final playlists = <PlaylistModel>[];

    for (final (name, description) in playlistInfo) {
      final shuffled = [...songs]..shuffle();

      final playlistSongs = <SongModel>[];

      while (playlistSongs.length < 5) {
        playlistSongs.addAll(shuffled);
      }

      playlistSongs.shuffle();

      playlists.add(
        PlaylistModel(
          name: name,
          description: description,
          songs: playlistSongs.take(5).toList(),
        ),
      );
    }

    return playlists;
  }
}
