import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageTransition extends CustomTransitionPage<void> {
  PageTransition.fadeThrough({
    LocalKey? key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (_, animation, secondAnimation, child) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: child,
        );
}
