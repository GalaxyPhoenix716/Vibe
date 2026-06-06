import 'dart:developer' as developer;
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/feature/home/model/song_model.dart';

part 'current_song_notifier.g.dart';

// 1. A global, un-changing provider strictly for the hardware player instance
@Riverpod(keepAlive: true)
AudioPlayer audioPlayerInstance(Ref ref) {
  final player = AudioPlayer();
  ref.onDispose(() {
    player.dispose();
  });
  return player;
}

@Riverpod(keepAlive: true)
class CurrentSongNotifier extends _$CurrentSongNotifier {
  @override
  SongModel? build() {
    // This state can reset or rebuild safely now without touching the player hardware
    return null;
  }

  void updateSong(SongModel song) async {
    // 2. Fetch the permanent player instance that survives UI changes
    final player = ref.read(audioPlayerInstanceProvider);

    try {
      // 3. Stop the active audio session safely
      await player.stop();

      // 4. Update the UI state so the song highlights visually
      state = song;

      // 5. Load and fire the stream
      final audioSource = AudioSource.uri(Uri.parse(song.song_url));
      await player.setAudioSource(audioSource);
      player.play();
    } on PlayerInterruptedException {
      developer.log('Audio load safely caught an interruption.');
    } catch (e, st) {
      developer.log('Audio player error', error: e, stackTrace: st);
      state = null;
    }
  }
}
