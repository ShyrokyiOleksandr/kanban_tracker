import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider._({
    this.height,
    this.width,
    this.color,
    this.margin,
  });

  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsets? margin;

  factory CustomDivider.horizontal({
    double? height = 1.0,
    Color? color = Colors.black12,
    EdgeInsets margin = EdgeInsets.zero,
  }) {
    return CustomDivider._(
      height: height,
      color: color,
      margin: margin,
    );
  }

  factory CustomDivider.vertical({
    double? width = 1.0,
    Color? color = Colors.black12,
    EdgeInsets margin = EdgeInsets.zero,
  }) {
    return CustomDivider._(
      width: width,
      color: color,
      margin: margin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
      margin: margin,
    );
  }
}
