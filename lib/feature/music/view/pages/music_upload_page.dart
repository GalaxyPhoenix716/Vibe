import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/core/widgets/adaptive_background.dart';

class MusicUploadPage extends StatefulWidget {
  const MusicUploadPage({super.key});

  @override
  State<MusicUploadPage> createState() => _MusicUploadPageState();
}

class _MusicUploadPageState extends State<MusicUploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          //Background Gradient
          AdaptiveBackground(),

          //Background Blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.black.withValues(alpha: 0.1)),
          ),

          //Main widgets
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: VibePadding.horizontalPadding,
                vertical: VibePadding.verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height:
                        MediaQuery.of(context).size.width -
                        (2 * VibePadding.horizontalPadding),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: VibeColors.card,
                      border: Border.all(width: 2, color: VibeColors.card),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text('Select Image'),
                  ),
                  const SizedBox(height: 15),
                  Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
