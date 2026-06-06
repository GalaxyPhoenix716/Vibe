import 'dart:math';
import 'package:vibe/core/constants.dart';
import 'package:vibe/feature/home/model/song_model.dart';

class PlaylistModel {
  final String playlistThumbnail;
  final String name;
  final String description;
  final List<SongModel> songs;

  PlaylistModel({
    required this.name,
    required this.description,
    required this.songs,
    required this.playlistThumbnail,
  });

  static String generatePlaylistName(List<String> tags) {
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

  static List<PlaylistModel> generatePlaylists(List<SongModel> songs) {
    int totalImageCount = 10;
    if (songs.length < 5) return [];

    final playlists = <PlaylistModel>[];
    final usedNames = <String>{};
    final usedSongIds = <String>{};
    final random = Random();

    // 1. Create a shuffled pool of image numbers (e.g., [1, 2, 3, 4...])
    var imageNumbersPool = List<int>.generate(totalImageCount, (i) => i + 1)
      ..shuffle(random);

    // 2. Group all available songs by their tags
    final tagToSongs = <String, List<SongModel>>{};
    for (final song in songs) {
      final tags = song.tags.split(',').map((e) => e.trim().toLowerCase());
      for (final tag in tags) {
        tagToSongs.putIfAbsent(tag, () => []).add(song);
      }
    }

    for (int i = 0; i < 8; i++) {
      // 3. Find tags that still have at least 5 unused songs
      final validTags = tagToSongs.keys.where((tag) {
        final unusedInTag = tagToSongs[tag]!
            .where((s) => !usedSongIds.contains(s.id))
            .length;
        return unusedInTag >= 5;
      }).toList();

      List<SongModel> playlistSongs = [];
      List<String> playlistTags = [];

      if (validTags.isNotEmpty) {
        final selectedTag = validTags[random.nextInt(validTags.length)];
        playlistTags = [selectedTag];

        final availableSongs = tagToSongs[selectedTag]!
            .where((s) => !usedSongIds.contains(s.id))
            .toList();
        availableSongs.shuffle(random);
        playlistSongs = availableSongs.take(5).toList();
      } else {
        final availableSongs = songs
            .where((s) => !usedSongIds.contains(s.id))
            .toList();
        final pool = availableSongs.length >= 5 ? availableSongs : songs;
        final shuffledPool = [...pool]..shuffle(random);
        playlistSongs = shuffledPool.take(5).toList();
      }

      for (final song in playlistSongs) {
        usedSongIds.add(song.id);
      }

      // 4. Generate a unique name safely
      String playlistName = generatePlaylistName(playlistTags);
      int attempt = 1;

      while (usedNames.contains(playlistName)) {
        playlistName = '${generatePlaylistName(playlistTags)} ${attempt++}';
      }
      usedNames.add(playlistName);

      // 5. Pick a unique cover image path safely
      if (imageNumbersPool.isEmpty && totalImageCount > 0) {
        imageNumbersPool = List<int>.generate(totalImageCount, (i) => i + 1)
          ..shuffle(random);
      }

      String? coverPath;
      if (imageNumbersPool.isNotEmpty) {
        final imageNumber = imageNumbersPool.removeLast();
        coverPath =
            'lib/core/images/playlist_images/playlist_img_$imageNumber.jpg';
      }

      // 6. Create the description text
      String description = '${playlistSongs.length} tracks curated for you';
      if (playlistTags.isNotEmpty) {
        final tag = playlistTags.first;
        description = 'Your essential $tag mix for the perfect vibe.';
      }

      playlists.add(
        PlaylistModel(
          name: playlistName,
          description: description,
          songs: playlistSongs,
          playlistThumbnail: coverPath!,
        ),
      );
    }

    return playlists;
  }
}
