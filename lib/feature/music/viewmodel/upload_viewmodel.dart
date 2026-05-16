import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vibe/core/utils.dart';
import '../model/upload_state.dart';

part 'upload_viewmodel.g.dart';

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

    state = state.copyWith(coverImage: image, dominantColor: dominantColor);
  }

  Future<void> selectAudioFile() async {
    final audio = await pickAudio();

    if (audio == null) {
      return;
    }

    state = state.copyWith(audioFile: audio);
  }

  void removeCoverImage() {
    state = state.copyWith(coverImage: null, dominantColor: Colors.black);
  }

  void removeAudioFile() {
    state = state.copyWith(audioFile: null);
  }

  Future<void> uploadSong({
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
      // upload repository logic later
    } finally {
      state = state.copyWith(isUploading: false);
    }
  }
}
