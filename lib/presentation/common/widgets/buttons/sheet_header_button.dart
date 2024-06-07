import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/common/widgets/main_button.dart';

class SheetHeaderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const SheetHeaderButton({
    required this.onPressed,
    required this.text,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton(
      height: 44,
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
