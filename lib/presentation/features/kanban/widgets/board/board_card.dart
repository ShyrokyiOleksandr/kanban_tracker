import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/features/kanban/widgets/board/board_model.dart';

class BoardCard extends StatelessWidget {
  final BoardItemModel item;
  final VoidCallback onTap;

  const BoardCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(item.title, maxLines: 1),
                Text(item.subtitle, maxLines: 1),
                Text(item.description, maxLines: 1),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Icon(Icons.supervised_user_circle_outlined)],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
