import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/common/colors/app_colors.dart';

class AppBottomSheetTitleText extends StatelessWidget {
  final String text;

  const AppBottomSheetTitleText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.dark,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.12,
        ),
      ),
    );
  }
}
