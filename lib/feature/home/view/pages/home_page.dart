import 'package:flutter/material.dart';
import 'package:vibe/core/constants.dart';
import 'package:vibe/core/theme/app_colors.dart';
import 'package:vibe/feature/home/view/widgets/user_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: VibeColors.backgroundColor),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: VibePadding.horizontalPadding,
          ),
          child: CustomScrollView(
            slivers: [SliverToBoxAdapter(child: UserHeader(userName: 'Mudit'))],
          ),
        ),
      ),
    );
  }
}
