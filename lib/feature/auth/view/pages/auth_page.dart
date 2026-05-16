import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/feature/auth/view/widgets/signup_button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: VibePadding.horizontalPadding,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(width: double.infinity),
                    BgImageStroke(),
                    BgImage(),
                    FloatingBadges(text: 'Live', angle: 6.6, top: 25, left: 15),
                    FloatingBadges(
                      text: 'Enjoy',
                      angle: -0.104,
                      top: 180,
                      right: 15,
                    ),
                    FloatingBadges(
                      text: 'Music',
                      angle: -0.122,
                      bottom: 20,
                      left: 13,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    height: 150,
                    decoration: BoxDecoration(
                      color: VibeColors.pink.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(250),
                        topLeft: Radius.circular(250),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.zero,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 18),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Let the ryhthm guide\nyour journey",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      SignUpButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingBadges extends StatelessWidget {
  final String text;
  final double angle;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  const FloatingBadges({
    super.key,
    required this.text,
    required this.angle,
    this.top,
    this.bottom,
    this.right,
    this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: angle,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 50,
              decoration: BoxDecoration(
                color: VibeColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: Text(text, style: TextStyle(fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }
}

class BgImageStroke extends StatelessWidget {
  const BgImageStroke({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -270,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.77,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(200),
          border: Border.all(
            width: 1,
            color: VibeColors.white.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}

class BgImage extends StatelessWidget {
  const BgImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.77,
      decoration: BoxDecoration(
        color: VibeColors.brighPurple,
        borderRadius: BorderRadius.circular(200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image(
          image: AssetImage('lib/core/images/auth_screen_image.jpg'),
        ),
      ),
    );
  }
}
