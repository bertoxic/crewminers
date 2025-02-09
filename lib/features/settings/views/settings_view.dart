import 'dart:math';
import 'package:flutter/material.dart';

// Custom Fan Widget
class SettingsScreen extends StatefulWidget {
  final double? size;  // Optional size parameter

  const SettingsScreen({Key? key, this.size}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _FanWidgetState();
}

class _FanWidgetState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isRotating = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    animation = Tween(begin: 0.0, end: 2 * pi).animate(controller);
  }

  void startFan() {
    if (!isRotating) {
      controller.repeat();
      setState(() {
        isRotating = true;
      });
    }
  }

  void stopFan() {
    if (isRotating) {
      controller.stop();
      setState(() {
        isRotating = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;

    // Use provided size or default to 20% of screen width
    final fanSize = widget.size ?? screenWidth * 0.2;

    return SizedBox(
      width: fanSize,
      height: fanSize,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[300]!,
              width: fanSize * 0.01, // Make border width proportional to fan size
            ),
          ),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return CustomPaint(
                painter: FanPainter(animation.value),
                size: Size(fanSize, fanSize),
              );
            },
          ),
        ),
      ),
    );
  }
}

// FanPainter remains the same as your code
class FanPainter extends CustomPainter {
  final double angle;

  FanPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // Draw center hub
    canvas.drawCircle(center, radius * 0.15, paint);

    // Save canvas state before rotation
    canvas.save();

    // Move to center and rotate
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    // Draw five hydrodynamic fan blades
    for (int i = 0; i < 5; i++) {
      canvas.save();
      canvas.rotate(i * 2 * pi / 5); // 72 degrees apart

      // Draw blade with a broader, curved hydrodynamic shape
      Path blade = Path()
        ..moveTo(radius * 0.151, 0) // Start slightly away from hub
        ..cubicTo(
          radius * 0.3, -radius * 0.1, // First control point
          radius * 0.6, -radius * 0.25, // Second control point
          radius * 0.9, -radius * 0.15, // End point
        )
        ..lineTo(radius * 0.9, radius * 0.15) // Blade tip width
        ..cubicTo(
          radius * 0.6, radius * 0.25, // First control point
          radius * 0.3, radius * 0.1, // Second control point
          radius * 0.151, 0, // Back to start, maintaining tiny gap
        )
        ..close();

      canvas.drawPath(blade, paint);
      canvas.restore();
    }

    // Restore canvas to original state
    canvas.restore();
  }

  @override
  bool shouldRepaint(FanPainter oldDelegate) => oldDelegate.angle != angle;
}