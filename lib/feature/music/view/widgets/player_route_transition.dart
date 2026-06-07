import 'package:flutter/material.dart';

class PlayerRouteTransition extends PageRouteBuilder {
  final Widget child;

  PlayerRouteTransition({required this.child})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
          );
          // Fade-in animation
          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          );
          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      );
}
