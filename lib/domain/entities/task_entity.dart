import 'package:flutter/foundation.dart';

// TODO: consider "timezone" field
class TaskEntity {
  // create/update
  final String projectId;
  final String sectionId;
  final String content;
  final String description;
  final List<String> labels;
  final bool? isCompleted;
  final int? order;
  final int? priority;
  final String? dueString;
  final DateTime? dueDateTime;
  final int? durationAmount;
  final String? durationUnit;
  // read/delete
  final String? id;
  final int? commentCount;
  final String? url;
  final String? creatorId;
  final DateTime? createdAt;

  TaskEntity({
    // create/update
    required this.projectId,
    required this.sectionId,
    required this.content,
    required this.description,
    required this.labels,
    this.isCompleted,
    this.order,
    this.priority,
    this.dueString,
    this.dueDateTime,
    this.durationAmount,
    this.durationUnit = "minute",
    // read/delete
    this.id,
    this.commentCount,
    this.url,
    this.creatorId,
    this.createdAt,
  });

  @override
  bool operator ==(covariant TaskEntity other) {
    if (identical(this, other)) return true;

    return other.projectId == projectId &&
        other.sectionId == sectionId &&
        other.content == content &&
        other.description == description &&
        listEquals(other.labels, labels) &&
        other.isCompleted == isCompleted &&
        other.order == order &&
        other.priority == priority &&
        other.dueString == dueString &&
        other.dueDateTime == dueDateTime &&
        other.durationAmount == durationAmount &&
        other.durationUnit == durationUnit &&
        other.id == id &&
        other.commentCount == commentCount &&
        other.url == url &&
        other.creatorId == creatorId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return projectId.hashCode ^
        sectionId.hashCode ^
        content.hashCode ^
        description.hashCode ^
        labels.hashCode ^
        isCompleted.hashCode ^
        order.hashCode ^
        priority.hashCode ^
        dueString.hashCode ^
        dueDateTime.hashCode ^
        durationAmount.hashCode ^
        durationUnit.hashCode ^
        id.hashCode ^
        commentCount.hashCode ^
        url.hashCode ^
        creatorId.hashCode ^
        createdAt.hashCode;
  }

  TaskEntity copyWith({
    String? projectId,
    String? sectionId,
    String? content,
    String? description,
    List<String>? labels,
    bool? isCompleted,
    int? order,
    int? priority,
    String? dueString,
    DateTime? dueDateTime,
    int? durationAmount,
    String? durationUnit,
    String? id,
    int? commentCount,
    String? url,
    String? creatorId,
    DateTime? createdAt,
  }) {
    return TaskEntity(
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      content: content ?? this.content,
      description: description ?? this.description,
      labels: labels ?? this.labels,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      dueString: dueString ?? this.dueString,
      dueDateTime: dueDateTime ?? this.dueDateTime,
      durationAmount: durationAmount ?? this.durationAmount,
      durationUnit: durationUnit ?? this.durationUnit,
      id: id ?? this.id,
      commentCount: commentCount ?? this.commentCount,
      url: url ?? this.url,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'TaskEntity(projectId: $projectId, sectionId: $sectionId, content: $content, description: $description, labels: $labels, isCompleted: $isCompleted, order: $order, priority: $priority, dueString: $dueString, dueDateTime: $dueDateTime, durationAmount: $durationAmount, durationUnit: $durationUnit, id: $id, commentCount: $commentCount, url: $url, creatorId: $creatorId, createdAt: $createdAt)';
  }
}
