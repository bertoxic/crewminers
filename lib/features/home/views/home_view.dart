// Example Screens
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Create an AnimationController for continuous rotation.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Standing Fan Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final rotation = _controller.value * 2 * pi;
            return CustomPaint(
              painter: FanPainter(rotation: rotation),
              size: const Size(300, 300),
            );
          },
        ),
      ),
    );
  }
}

class FanPainter extends CustomPainter {
  final double rotation;

  FanPainter({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the central hub.
    final hubPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 15, hubPaint);

    // Blade properties.
    // Increase the blade width and length for a bigger, more prominent wing.
    final double bladeLength = size.width / 2 - 30;
    final double bladeWidth = 40.0;

    final bladePaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    // Draw three blades using a custom curved path.
    for (int i = 0; i < 3; i++) {
      canvas.save();
      // Calculate each blade's angle.
      final double bladeAngle = rotation + (2 * pi / 3) * i;
      canvas.translate(center.dx, center.dy);
      canvas.rotate(bladeAngle);

      // Create a curved path for the fan blade.
      final Path bladePath = Path();
      // Start at the inner edge of the blade (just outside the hub).
      bladePath.moveTo(20, -bladeWidth / 2);
      // Curve outwards towards the tip.
      bladePath.quadraticBezierTo(
          bladeLength / 2, -bladeWidth, bladeLength, 0);
      // Curve back towards the inner edge.
      bladePath.quadraticBezierTo(
          bladeLength / 2, bladeWidth, 20, bladeWidth / 2);
      bladePath.close();

      // Draw the blade.
      canvas.drawPath(bladePath, bladePaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant FanPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}