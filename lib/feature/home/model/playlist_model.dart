import 'dart:math';

import 'package:vibe/core/constants.dart';
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

  String generatePlaylistName(List<String> tags) {
    final Random random = Random();
    final normalizedTags = tags.map((e) => e.trim().toLowerCase()).toList();

    final moodPool = <String>[];
    final genrePool = <String>[];

    for (final tag in normalizedTags) {
      moodPool.addAll(PlaylistWords.moodWords[tag] ?? []);
      genrePool.addAll(PlaylistWords.genreWords[tag] ?? []);
    }

    if (moodPool.isNotEmpty && genrePool.isNotEmpty) {
      return '${moodPool[random.nextInt(moodPool.length)]} '
          '${genrePool[random.nextInt(genrePool.length)]}';
    }

    if (moodPool.isNotEmpty) {
      return '${moodPool[random.nextInt(moodPool.length)]} '
          '${PlaylistWords.fallbackWords[random.nextInt(PlaylistWords.fallbackWords.length)]}';
    }

    if (genrePool.isNotEmpty) {
      return '${genrePool[random.nextInt(genrePool.length)]} '
          '${PlaylistWords.fallbackWords[random.nextInt(PlaylistWords.fallbackWords.length)]}';
    }

    return 'Daily Mix';
  }

  List<PlaylistModel> generatePlaylists(List<SongModel> songs) {
    if (songs.length < 5) {
      return [];
    }

    final shuffled = [...songs]..shuffle();
    final playlists = <PlaylistModel>[];
    final usedNames = <String>{};

    int currentIndex = 0;
    for (int i = 0; i < 8; i++) {
      final playlistSongs = <SongModel>[];

      while (playlistSongs.length < 5) {
        playlistSongs.add(shuffled[currentIndex % shuffled.length]);

        currentIndex++;
      }

      final tagFrequency = <String, int>{};

      for (final song in playlistSongs) {
        final tags = song.tags.split(',').map((e) => e.trim().toLowerCase());
        for (final tag in tags) {
          tagFrequency[tag] = (tagFrequency[tag] ?? 0) + 1;
        }
      }

      final dominantTags = tagFrequency.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      String playlistName;
      do {
        playlistName = generatePlaylistName(
          dominantTags.take(2).map((e) => e.key).toList(),
        );
      } while (usedNames.contains(playlistName));

      usedNames.add(playlistName);

      playlists.add(
        PlaylistModel(
          name: playlistName,
          description: '${playlistSongs.length} songs curated for you',
          songs: playlistSongs,
        ),
      );
    }

    return playlists;
  }
}
