import 'package:flutter/material.dart';

class ButtonClip extends StatelessWidget {
  final Widget child;
  final Function onPress;
  final Color color;
  final Color? highlightColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  const ButtonClip({Key? key,
    required this.child,
    required this.onPress,
    required this.color,
    required this.radius,
    this.highlightColor,
    required this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:BorderRadius.circular(radius),
      child: Material(
        color: color,
        child: InkWell(
            highlightColor:highlightColor,
            onTap: ()=>onPress(),
            child: Padding(
              padding:padding,
              child: child,
            )),
      ),
    );
  }
}
