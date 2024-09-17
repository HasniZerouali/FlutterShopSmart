import 'package:flutter/material.dart';
import 'package:shopsmart_users/widgets/rotating_Indicator_widget.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager({
    super.key,
    required this.isLoading,
    required this.child,
  });
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Container(
            color: Colors.black.withOpacity(0.2), // Semi-transparent overlay
            child: Center(
              child: RotatingProgressIndicator(),
            ),
          ),
        ],
      ],
    );
  }
}
