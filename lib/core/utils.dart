import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:palette_generator_master/palette_generator_master.dart';

void showSnackbar(
  BuildContext context, {
  required String title,
  required String message,
  required ContentType contentType,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  Color? color,
}) {
  final snackbar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
      color: color,
      titleTextStyle: titleTextStyle,
      messageTextStyle: messageTextStyle,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}

Future<Color> generatePalette(ImageProvider imageProvider) async {
  final PaletteGeneratorMaster paletteGenerator =
      await PaletteGeneratorMaster.fromImageProvider(
        imageProvider,
        maximumColorCount: 16,
        generateHarmony: true, // Generate color harmony
      );

  final Color? dominantColor = paletteGenerator.dominantColor?.color;

  return dominantColor!;
}

Future<File?> pickAudio() async {
  try {
    final filePickerRes = await FilePicker.pickFiles(type: FileType.audio);

    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }

    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePicker.pickFiles(type: FileType.image);

    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }

    return null;
  } catch (e) {
    return null;
  }
}
