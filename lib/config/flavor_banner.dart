// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:affiliate_platform/config/config.dart';
import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Config.appFlavor is Development) {
      if (Config.appMode == AppMode.release) {
        return child;
      } else {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Banner(
            color: Colors.teal,
            message: 'Dev',
            location: BannerLocation.topEnd,
            child: child,
          ),
        );
      }
    } else {
      return child;
    }
  }
}
