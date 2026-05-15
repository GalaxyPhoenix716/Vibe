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

Future<Color> generatePalette() async {
  final ImageProvider imageProvider = AssetImage('lib/core/images/img.png');

  final PaletteGeneratorMaster paletteGenerator =
      await PaletteGeneratorMaster.fromImageProvider(
        imageProvider,
        maximumColorCount: 16,
        generateHarmony: true, // Generate color harmony
      );

  // Access extracted colors
  final Color? dominantColor = paletteGenerator.dominantColor?.color;
  // final Color? vibrantColor = paletteGenerator.vibrantColor?.color;
  // final Color? mutedColor = paletteGenerator.mutedColor?.color;

  // // Get all extracted colors
  // final List<PaletteColorMaster> allColors = paletteGenerator.paletteColors;

  // // Get harmony colors
  // final List<ColorHarmonyMaster> harmonyColors = paletteGenerator.harmonyColors;

  // Use colors in your UI
  return dominantColor!;
}
