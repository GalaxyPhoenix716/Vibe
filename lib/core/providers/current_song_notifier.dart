import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/core/utils.dart';
import 'package:vibe/feature/home/model/song_model.dart';

part 'current_song_notifier.g.dart';

@Riverpod(keepAlive: true)
AudioPlayer audioPlayerInstance(Ref ref) {
  final player = AudioPlayer();
  ref.onDispose(() {
    player.dispose();
  });
  return player;
}

@riverpod
Future<Color> currentSongColor(Ref ref) async {
  final currentSong = ref.watch(currentSongProvider);
  if (currentSong == null) {
    return Colors.black;
  }
  return generatePalette(currentSong.thumbnail_url);
}

@Riverpod(keepAlive: true)
class CurrentSongNotifier extends _$CurrentSongNotifier {
  @override
  SongModel? build() {
    return null;
  }

  void updateSong(SongModel song) async {
    final player = ref.read(audioPlayerInstanceProvider);

    try {
      await player.stop();

      state = song;

      final audioSource = AudioSource.uri(Uri.parse(song.song_url));
      await player.setAudioSource(audioSource);
      player.play();
    } catch (e, st) {
      developer.log('Audio player error', error: e, stackTrace: st);
      state = null;
    }
  }

  void playPause() {
    final player = ref.read(audioPlayerInstanceProvider);

    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }
}

@riverpod
Stream<bool> isPlaying(Ref ref) {
  final player = ref.watch(audioPlayerInstanceProvider);
  return player.playingStream;
}

@riverpod
Stream<Duration?> currentSongDuration(Ref ref) {
  final player = ref.watch(audioPlayerInstanceProvider);
  return player.durationStream;
}

@riverpod
Stream<Duration> currentSongPosition(Ref ref) {
  final player = ref.watch(audioPlayerInstanceProvider);
  return player.positionStream;
}
