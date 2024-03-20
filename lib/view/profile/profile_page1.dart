// ignore_for_file: cascade_invocations, lines_longer_than_80_chars

import 'package:flutter/material.dart';

class ProfilePage1 extends StatelessWidget {
  const ProfilePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ClipPath(
          clipper: ClipPathClipper(),
          child: Container(
            // height: 300,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class ClipPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;

    final path = Path();

    // (0,0)  (top left)
    // path.lineTo(0, height); // (0,1)  (top right)
    // path.lineTo(width, height); // (1,1)  (bottom right)
    // path.lineTo(width, 0); // (1,0) (bottom left)

    // path.lineTo(0, height); // (0,1)  (top right)
    // path.quadraticBezierTo(
    //   // Special Point for making curve (bottom center with height 100 minus)
    //   width * 0.5,
    //   height - 100,
    //   // Special Point for making curve (bottom center with height 100 minus)
    //   // (1,1) ==> bottom right
    //   width,
    //   height,
    //   // (1,1) ==> bottom right
    // );
    // path.lineTo(width, 0);
    // path.close();

    // Border radius at all sides
    // Move to the initial position at the middle left of the container
    // path.moveTo(0, size.height / 2);

    // // Line to the starting point of the bottom left curve
    // // Start of the bottom left curve
    // path.lineTo(0, size.height - radius);

    // // Quadratic Bezier curve from the starting point of the bottom left curve to the bottom left corner
    // // Control point: (0, size.height) - the bottom left corner
    // // End point: (radius, size.height) - the bottom left corner
    // path.quadraticBezierTo(0, size.height, radius, size.height);

    // // Line to the starting point of the bottom right curve
    // // End of the bottom left curve
    // path.lineTo(size.width - radius, size.height);

    // // Quadratic Bezier curve from the bottom left corner to the bottom right corner
    // // Control point: (size.width, size.height) - the bottom right corner
    // // End point: (size.width, size.height - radius) - the bottom right corner
    // path.quadraticBezierTo(size.width, size.height, size.width, size.height - radius);

    // // Line to the starting point of the top right curve
    // // End of the bottom right curve
    // path.lineTo(size.width, radius);

    // // Quadratic Bezier curve from the bottom right corner to the top right corner
    // // Control point: (size.width, 0) - the top right corner
    // // End point: (size.width - radius, 0) - the top right corner
    // path.quadraticBezierTo(size.width, 0, size.width - radius, 0);

    // // Line to the starting point of the top left curve
    // // End of the top right curve
    // path.lineTo(radius, 0);

    // // Quadratic Bezier curve from the top right corner to the top left corner
    // // Control point: (0, 0) - the top left corner
    // // End point: (0, radius) - the top left corner
    // path.quadraticBezierTo(0, 0, 0, radius);

    // // Close the path by connecting the top left corner to the initial point at the middle left
    // path.close();
    // Border radius at all sides

    // // Curve at bottom left
    // path.moveTo(0, size.height / 2);
    // path.lineTo(0, size.height - 30);
    // path.quadraticBezierTo(0, size.height, 30, size.height);
    // path.lineTo(size.width, size.height); // Draw right edge
    // path.lineTo(size.width, 0); // Draw top edge
    // path.lineTo(0, 0);
    // path.close();
    // // Curve at bottom left

    // Curve at bottom left
    path.moveTo(0, size.height / 2);
    path.lineTo(0, (size.height / 3) - 30);
    path.quadraticBezierTo(0, size.height / 3, size.width - 50 , (size.height/3)+120);
    path.lineTo(size.width, size.height + 60); // Draw right edge
    path.lineTo(size.width - 30, size.height);  
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0); // Draw top edge
    path.lineTo(0, 0);
    path.close();
    // Curve at bottom left

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
