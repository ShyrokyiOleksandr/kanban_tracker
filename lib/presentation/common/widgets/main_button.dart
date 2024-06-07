import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.height,
    required this.onTap,
    required this.child,
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(12.0),
    ),
    this.width,
    this.splashColor,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.childAlignment = Alignment.center,
    this.padding = EdgeInsets.zero,
    this.shape,
    super.key,
  });

  final double height;
  final VoidCallback onTap;
  final Widget child;
  final Color color;
  final BorderRadius? borderRadius;
  final double? width;
  final Color? splashColor;
  final Color? focusColor;
  final Color? hoverColor;
  final FocusNode? focusNode;
  final Alignment childAlignment;
  final EdgeInsets padding;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        color: color,
        borderRadius: borderRadius,
        shape: shape,
        child: InkWell(
          focusNode: focusNode,
          borderRadius: borderRadius,
          splashColor: splashColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          onTap: () {
            focusNode?.requestFocus();
            onTap.call();
          },
          child: Padding(
            padding: padding,
            child: Align(
              alignment: childAlignment,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
