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
    File? coverImage,
    File? audioFile,
    Color? dominantColor,
    bool? isUploading,
  }) {
    return UploadState(
      coverImage: coverImage ?? this.coverImage,
      audioFile: audioFile ?? this.audioFile,
      dominantColor: dominantColor ?? this.dominantColor,
      isUploading: isUploading ?? this.isUploading,
    );
  }
}
