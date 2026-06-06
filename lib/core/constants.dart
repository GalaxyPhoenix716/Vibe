import 'package:flutter_dotenv/flutter_dotenv.dart';

class VibePadding {
  static const double horizontalPadding = 20;
  static const double verticalPadding = 15;
}

class ServerConstant {
  static String serverURL = dotenv.env['BACKEND_URL']!;
}

class PlaylistWords {
  static const Map<String, List<String>> moodWords = {
    'chill': ['Velvet', 'Midnight', 'Moonlight', 'Dream', 'Cloud'],
    'workout': ['Pulse', 'Adrenaline', 'Power', 'Energy', 'Beast'],
    'study': ['Focus', 'Flow', 'Deep', 'Quiet', 'Mind'],
    'travel': ['Highway', 'Journey', 'Road', 'Wander', 'Escape'],
    'party': ['Neon', 'Electric', 'Weekend', 'Dance', 'Night'],
  };

  static const Map<String, List<String>> genreWords = {
    'pop': ['Hits', 'Essentials', 'Anthems', 'Favorites'],
    'edm': ['Rush', 'Drop', 'Frequency', 'Beats'],
    'rock': ['Legends', 'Rebellion', 'Storm', 'Fire'],
    'hiphop': ['Flow', 'Bars', 'Rhythm', 'Empire'],
    'instrumental': ['Sessions', 'Harmony', 'Echoes', 'Soundscapes'],
  };

  static const List<String> fallbackWords = [
    'Mix',
    'Collection',
    'Sessions',
    'Vibes',
    'Radio',
  ];
}
