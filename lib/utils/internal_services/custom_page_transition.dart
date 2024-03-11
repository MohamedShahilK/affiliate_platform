// ignore_for_file: public_member_api_docs, sort_constructors_first, strict_raw_type, lines_longer_than_80_chars
import 'package:flutter/material.dart';


class CustomSlidePageTransition extends PageRouteBuilder {  
  final Widget page;
  CustomSlidePageTransition({
    required this.page,
    // super.settings,
  }) : super(
          pageBuilder: (ctx, animation, secondaryAnimation) => page,
          reverseTransitionDuration: const Duration(milliseconds: 200),
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  RouteTransitionsBuilder get transitionsBuilder =>
      (context, animation, secondaryAnimation, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: page,
          );
}
