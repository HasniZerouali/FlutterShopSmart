import 'package:flutter/material.dart';

class RotatingProgressIndicator extends StatefulWidget {
  const RotatingProgressIndicator({super.key});

  @override
  _RotatingProgressIndicatorState createState() =>
      _RotatingProgressIndicatorState();
}

class _RotatingProgressIndicatorState extends State<RotatingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Rotate every second
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CircularProgressIndicator(
        color: Colors.deepPurple,
        backgroundColor: Colors.grey[300],
        strokeWidth: 6.0,
        semanticsLabel: 'Loading...',
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
