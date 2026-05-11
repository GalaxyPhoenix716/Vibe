import 'package:flutter/material.dart';
import 'package:vibe/core/theme/app_colors.dart';

class AppTheme {
  static final darkMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: VibeColors.backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: VibeColors.backgroundColor,),
    textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'SF Pro'),
  );
}
