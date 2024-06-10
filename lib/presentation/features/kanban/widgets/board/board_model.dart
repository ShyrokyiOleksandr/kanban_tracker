import 'dart:math';

class BoardItemModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final List<String> labels;

  BoardItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.labels,
  });

  static BoardItemModel stub() {
    return BoardItemModel(
      id: "Task #${Random().nextInt(100)}",
      title: "Task #${Random().nextInt(100)}",
      subtitle: "Subtitle of task",
      description: "Description of task",
      labels: ["Shopping"],
    );
  }
}
