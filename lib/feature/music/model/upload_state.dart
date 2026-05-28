import 'dart:io';
import 'package:flutter/material.dart';

class UploadState {
  final File? coverImage;
  final File? audioFile;
  final Duration? audioDuration;
  final Color dominantColor;
  final bool isUploading;

  const UploadState({
    this.coverImage,
    this.audioFile,
    this.audioDuration,
    required this.dominantColor,
    this.isUploading = false,
  });

  UploadState copyWith({
    ValueGetter<File?>? coverImage,
    ValueGetter<File?>? audioFile,
    ValueGetter<Duration?>? audioDuration,
    ValueGetter<String?>? waveformPath,
    Color? dominantColor,
    bool? isUploading,
  }) {
    return UploadState(
      coverImage: coverImage != null ? coverImage() : this.coverImage,
      audioFile: audioFile != null ? audioFile() : this.audioFile,
      audioDuration: audioDuration != null
          ? audioDuration()
          : this.audioDuration,
      dominantColor: dominantColor ?? this.dominantColor,
      isUploading: isUploading ?? this.isUploading,
    );
  }
}
