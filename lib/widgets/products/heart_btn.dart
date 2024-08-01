import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget(
      {super.key, this.size = 22, this.color = Colors.transparent});
  final double size;
  final Color? color;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () {},
        icon: Icon(
          IconlyLight.heart,
          size: widget.size,
          //ndiro widget.size khararch var size 3arafnah khareg l State fi StatfulWidget
        ),
      ),
    );
  }
}
