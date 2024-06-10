import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/common/extensions/build_context_extensions.dart';

class FailureDisplay extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const FailureDisplay({
    required this.message,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(context.strings.tryAgainAction),
          ),
        ],
      ),
    );
  }
}
