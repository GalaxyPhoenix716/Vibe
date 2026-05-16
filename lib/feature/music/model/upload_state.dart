import 'dart:io';
import 'package:flutter/material.dart';

class UploadState {
  final File? coverImage;
  final File? audioFile;
  final Color dominantColor;
  final bool? isUploading;

  const UploadState({
    this.coverImage,
    this.audioFile,
    required this.dominantColor,
    this.isUploading,
  });

  UploadState copyWith({
    ValueGetter<File?>? coverImage,
    ValueGetter<File?>? audioFile,
    Color? dominantColor,
    bool? isUploading,
  }) {
    return UploadState(
      coverImage: coverImage != null ? coverImage() : this.coverImage,
      audioFile: audioFile != null ? audioFile() : this.audioFile,
      dominantColor: dominantColor ?? this.dominantColor,
      isUploading: isUploading ?? this.isUploading,
    );
  }
}
