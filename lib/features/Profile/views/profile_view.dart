import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Profile Screen', style: Theme.of(context).textTheme.titleLarge),
//     );
//   }
// }


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotating Fan'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: RotatingFan(),
        ),
      ),
    );
  }
}

class RotatingFan extends StatefulWidget {
  @override
  _RotatingFanState createState() => _RotatingFanState();
}

class _RotatingFanState extends State<RotatingFan> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust speed of rotation
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: FanPainter(rotationAngle: _controller.value * 360), // Pass rotation angle
        );
      },
    );
  }
}

class FanPainter extends CustomPainter {
  final double rotationAngle;

  FanPainter({required this.rotationAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4; // Radius of the fan circle
    final bladeWidth = size.width * 0.3; // Increased blade width
    final bladeHeight = size.height * 0.5; // Increased blade height

    // Paint for the fan hub
    final hubPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;

    // Paint for the fan blades
    final bladePaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    // Save the canvas state before applying transformations
    canvas.save();
    canvas.translate(center.dx, center.dy); // Move origin to the center
    canvas.rotate(rotationAngle * (3.141592653589793 / 180)); // Apply rotation
    canvas.translate(-center.dx, -center.dy); // Restore origin

    // Draw the fan hub (center circle)
    canvas.drawCircle(center, size.width * 0.1, hubPaint);

    // Draw the fan blades
    for (int i = 0; i < 3; i++) {
      final angle = (i * 120) * (3.141592653589793 / 180); // Convert degrees to radians
      final path = Path();

      // Define the blade shape using a triangle-like path
      path.moveTo(center.dx, center.dy);
      path.lineTo(
        center.dx + bladeWidth * cos(angle),
        center.dy + bladeWidth * sin(angle),
      );
      path.lineTo(
        center.dx + bladeHeight * cos(angle + 0.5),
        center.dy + bladeHeight * sin(angle + 0.5),
      );
      path.close();

      // Draw the blade
      canvas.drawPath(path, bladePaint);
    }

    // Restore the canvas state after transformations
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when the rotation angle changes
  }
}