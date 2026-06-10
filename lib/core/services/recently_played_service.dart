import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe/feature/home/model/song_model.dart';

class RecentlyPlayedService {
  static const String _boxName = 'recently_played_box';
  static const String _key = 'history';

  // Initialize the Hive box
  static Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  // Get the list of recently played songs
  static List<SongModel> getRecentlyPlayed() {
    final box = Hive.box(_boxName);
    final dynamic rawList = box.get(_key);
    if (rawList == null || rawList is! List) {
      return [];
    }
    return rawList
        .map((item) => SongModel.fromJson(item as String))
        .toList();
  }

  // Add a new song to the recently played list
  static Future<void> addSong(SongModel song) async {
    final box = Hive.box(_boxName);
    final currentSongs = getRecentlyPlayed();

    // Remove song if it already exists in the list to avoid duplicate entries
    currentSongs.removeWhere((item) => item.id == song.id);

    // Insert at index 0 (top of recently played)
    currentSongs.insert(0, song);

    // Limit list to a max of 20 songs
    if (currentSongs.length > 20) {
      currentSongs.removeRange(20, currentSongs.length);
    }

    // Serialize all songs to JSON string representations
    final serializedList = currentSongs.map((e) => e.toJson()).toList();

    await box.put(_key, serializedList);
  }
}
