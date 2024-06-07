import 'package:flutter/material.dart';

class AppBottomSheetDragAnchor extends StatelessWidget {
  static const EdgeInsets margin = EdgeInsets.only(top: 8, bottom: 10);
  static const double _height = 5;

  static double get boxHeight => _height + margin.vertical;

  const AppBottomSheetDragAnchor({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width / 10,
        height: _height,
        margin: margin,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: Color(0xFFEBEBEB),
        ),
      ),
    );
  }
}
