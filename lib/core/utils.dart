import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showSnackbar(
  BuildContext context,
  String title,
  String message,
  ContentType contentType,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  Color? color,
) {
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
