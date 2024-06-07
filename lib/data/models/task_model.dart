import 'package:flutter/foundation.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart'; // For mapEquals and listEquals

class TaskModel {
  final String creatorId;
  final String createdAt;
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

  TaskModel({
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

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      creatorId: json['creator_id'],
      createdAt: json['created_at'],
      assigneeId: json['assignee_id'],
      assignerId: json['assigner_id'],
      commentCount: json['comment_count'],
      isCompleted: json['is_completed'],
      content: json['content'],
      description: json['description'],
      due: json['due'] != null ? Map<String, dynamic>.from(json['due']) : null,
      duration: json['duration'] != null
          ? Map<String, dynamic>.from(json['duration'])
          : null,
      id: json['id'],
      labels: List<String>.from(json['labels']),
      order: json['order'],
      priority: json['priority'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      parentId: json['parent_id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creator_id': creatorId,
      'created_at': createdAt,
      'assignee_id': assigneeId,
      'assigner_id': assignerId,
      'comment_count': commentCount,
      'is_completed': isCompleted,
      'content': content,
      'description': description,
      'due': due,
      'duration': duration,
      'id': id,
      'labels': labels,
      'order': order,
      'priority': priority,
      'project_id': projectId,
      'section_id': sectionId,
      'parent_id': parentId,
      'url': url,
    };
  }

  factory TaskModel.fromDomain(TaskEntity entity) {
    return TaskModel(
      creatorId: entity.creatorId,
      createdAt: entity.createdAt.toIso8601String(),
      assigneeId: entity.assigneeId,
      assignerId: entity.assignerId,
      commentCount: entity.commentCount,
      isCompleted: entity.isCompleted,
      content: entity.content,
      description: entity.description,
      due: entity.due,
      duration: entity.duration,
      id: entity.id,
      labels: entity.labels,
      order: entity.order,
      priority: entity.priority,
      projectId: entity.projectId,
      sectionId: entity.sectionId,
      parentId: entity.parentId,
      url: entity.url,
    );
  }

  TaskEntity toDomain() {
    return TaskEntity(
      creatorId: creatorId,
      createdAt: DateTime.parse(createdAt),
      assigneeId: assigneeId,
      assignerId: assignerId,
      commentCount: commentCount,
      isCompleted: isCompleted,
      content: content,
      description: description,
      due: due,
      duration: duration,
      id: id,
      labels: labels,
      order: order,
      priority: priority,
      projectId: projectId,
      sectionId: sectionId,
      parentId: parentId,
      url: url,
    );
  }

  @override
  bool operator ==(covariant TaskModel other) {
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
