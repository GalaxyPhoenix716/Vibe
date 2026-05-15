import 'dart:ui';
import 'package:flutter/material.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  alignment: Alignment.center,
                  child: Text('Select Image'),
                ),
                const SizedBox(height: 15),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


