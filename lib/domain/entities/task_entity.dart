// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class TaskEntity {
  final String creatorId;
  final DateTime createdAt;
  final String? assigneeId;
  final String? assignerId;
  final int commentCount;
  final bool isCompleted;
  final String content;
  final String description;
  final Map<String, dynamic>? due;
  final Map<String, dynamic>? duration;
  final String id;
  final List<String> labels;
  final int order;
  final int priority;
  final String projectId;
  final String? sectionId;
  final String? parentId;
  final String url;

  TaskEntity({
    required this.creatorId,
    required this.createdAt,
    required this.assigneeId,
    required this.assignerId,
    required this.commentCount,
    required this.isCompleted,
    required this.content,
    required this.description,
    required this.due,
    required this.duration,
    required this.id,
    required this.labels,
    required this.order,
    required this.priority,
    required this.projectId,
    required this.sectionId,
    required this.parentId,
    required this.url,
  });

  @override
  bool operator ==(covariant TaskEntity other) {
    if (identical(this, other)) return true;

    return other.creatorId == creatorId &&
        other.createdAt == createdAt &&
        other.assigneeId == assigneeId &&
        other.assignerId == assignerId &&
        other.commentCount == commentCount &&
        other.isCompleted == isCompleted &&
        other.content == content &&
        other.description == description &&
        mapEquals(other.due, due) &&
        mapEquals(other.duration, duration) &&
        other.id == id &&
        listEquals(other.labels, labels) &&
        other.order == order &&
        other.priority == priority &&
        other.projectId == projectId &&
        other.sectionId == sectionId &&
        other.parentId == parentId &&
        other.url == url;
  }

  @override
  int get hashCode {
    return creatorId.hashCode ^
        createdAt.hashCode ^
        assigneeId.hashCode ^
        assignerId.hashCode ^
        commentCount.hashCode ^
        isCompleted.hashCode ^
        content.hashCode ^
        description.hashCode ^
        due.hashCode ^
        duration.hashCode ^
        id.hashCode ^
        labels.hashCode ^
        order.hashCode ^
        priority.hashCode ^
        projectId.hashCode ^
        sectionId.hashCode ^
        parentId.hashCode ^
        url.hashCode;
  }
}
