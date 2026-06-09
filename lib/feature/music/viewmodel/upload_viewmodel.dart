import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/core/utils.dart';
import 'package:vibe/feature/auth/viewmodel/auth_viewmodel.dart';
import 'package:vibe/feature/home/model/song_model.dart';
import 'package:vibe/feature/music/repositories/music_repository.dart';
import '../model/upload_state.dart';

part 'upload_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(Ref ref) async {
  final token = ref.read(authRepositoryProvider).token!;
  final res = await ref
      .watch(musicRepositoryProvider)
      .getAllSongs(token: token);

  return res.fold(
    (failure) {
      throw Exception(failure.message);
    },
    (success) {
      return success;
    },
  );
}

@riverpod
Future<List<SongModel>> getAllFavSongs(Ref ref) async {
  final token = ref.read(authRepositoryProvider).token!;
  final res = await ref
      .watch(musicRepositoryProvider)
      .getAllFavSongs(token: token);

  return res.fold(
    (failure) {
      throw Exception(failure.message);
    },
    (success) {
      return success;
    },
  );
}

@riverpod
class UploadViewModel extends _$UploadViewModel {
  @override
  UploadState build() {
    return const UploadState(dominantColor: Colors.black);
  }

  Future<void> selectCoverImage() async {
    final image = await pickImage();

    if (image == null) {
      return;
    }

    final dominantColor = await generatePalette(FileImage(image));

    state = state.copyWith(
      coverImage: () => image,
      dominantColor: dominantColor,
    );
  }

  Future<void> selectAudioFile() async {
    final audio = await pickAudio();

    if (audio == null) {
      return;
    }

    final player = AudioPlayer();
    await player.setFilePath(audio.path);
    final duration = player.duration;

    state = state.copyWith(
      audioFile: () => audio,
      audioDuration: () => duration,
    );

    await player.dispose();
  }

  void removeCoverImage() {
    state = state.copyWith(
      coverImage: () => null,
      dominantColor: VibeColors.backgroundColor,
    );
  }

  void removeAudioFile() {
    state = state.copyWith(audioFile: () => null);
  }

  Future<String> uploadSong({
    required String songName,
    required String artistName,
  }) async {
    if (state.coverImage == null) {
      throw Exception('Please select a cover image');
    }

    if (state.audioFile == null) {
      throw Exception('Please select a song');
    }

    if (songName.trim().isEmpty) {
      throw Exception('Please enter song name');
    }

    if (artistName.trim().isEmpty) {
      throw Exception('Please enter artist name');
    }

    state = state.copyWith(isUploading: true);

    try {
      final repository = ref.read(musicRepositoryProvider);
      final token = ref.read(authRepositoryProvider).token;

      if (token == null) {
        throw Exception('User not authenticated');
      }

      final tagsString = state.selectedTags.join(',');

      final result = await repository.uploadSong(
        audio: state.audioFile!,
        image: state.coverImage!,
        artist: artistName,
        songName: songName,
        tags: tagsString,
        token: token,
      );

      return result.fold(
        (failure) {
          throw Exception(failure.message);
        },
        (success) {
          return success;
        },
      );
    } finally {
      state = state.copyWith(isUploading: false);
    }
  }

  Future<bool> favSong({required String songId}) async {
    try {
      final repository = ref.read(musicRepositoryProvider);
      final token = ref.read(authRepositoryProvider).token;

      if (token == null) {
        throw Exception('User not authenticated');
      }

      final result = await repository.favSong(songId: songId, token: token);

      return result.fold(
        (failure) {
          throw Exception(failure.message);
        },
        (success) {
          return success;
        },
      );
    } finally {
      state = state.copyWith(isUploading: false);
    }
  }

  void toggleTag(String tag) {
    final tags = [...state.selectedTags];

    if (tags.contains(tag)) {
      tags.remove(tag);
    } else {
      tags.add(tag);
    }

    state = state.copyWith(selectedTags: tags);
  }

  void resetState() {
    state = const UploadState(dominantColor: Colors.black);
  }
}
