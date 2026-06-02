import 'package:flutter/material.dart';
import 'package:vibe/core/theme/app_colors.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  const UserHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, $userName!",
            style: TextStyle(
              color: VibeColors.greyText,
              fontFamily: 'SF Pro',
              fontSize: 32,
            ),
          ),

          RichText(
            text: TextSpan(
              text: "Music mix ",
              style: TextStyle(
                color: VibeColors.greyText,
                fontFamily: 'SF Pro',
                fontSize: 32,
              ),
              children: [
                TextSpan(
                  text: "for you.",
                  style: TextStyle(
                    color: VibeColors.white,
                    fontFamily: 'SF Pro',
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
