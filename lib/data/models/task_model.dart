// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:kanban_tracker/domain/entities/task_entity.dart'; // For mapEquals and listEquals

class TaskModel {
  // create/update
  final String projectId;
  final String sectionId;
  final String content;
  final String description;
  final List<String> labels;
  final bool? isCompleted;
  final int? order;
  final int? priority;
  final Map<String, dynamic>? due;
  final Map<String, dynamic>? duration;
  // read/delete
  final String? id;
  final int? commentCount;
  final String? url;
  final String? creatorId;
  final String? createdAt;

  TaskModel({
    // create/update
    required this.projectId,
    required this.sectionId,
    required this.content,
    required this.description,
    required this.labels,
    this.isCompleted,
    this.order,
    this.priority,
    this.due,
    this.duration,
    // read/delete
    this.id,
    this.creatorId,
    this.commentCount,
    this.createdAt,
    this.url,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      // create/update
      projectId: json['project_id'],
      sectionId: json['section_id'],
      content: json['content'],
      description: json['description'],
      labels: List<String>.from(json['labels']),

      isCompleted: json['is_completed'],
      order: json['order'],
      priority: json['priority'],
      due: json['due'] != null && (json['due'] as Map).isNotEmpty
          ? {
              "datetime": json['due']['datetime'],
              "string": json['due']['string'],
            }
          : null,
      duration: json['duration'] != null && (json['duration'] as Map).isNotEmpty
          ? {
              "amount": json['duration']['amount'],
              "unit": json['duration']['unit'],
            }
          : null,

      // read/delete
      id: json['id'],
      commentCount: json['comment_count'],
      url: json['url'],
      creatorId: json['creator_id'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    var jsonMap = {
      'project_id': projectId,
      'section_id': sectionId,
      'content': content,
      'description': description,
      'labels': labels,
    };

    if (isCompleted != null) jsonMap['is_completed'] = isCompleted!;
    if (order != null) jsonMap['order'] = order!;
    if (priority != null) jsonMap['priority'] = priority!;
    if (due != null && due!.isNotEmpty) {
      if (due!['datetime'] != null) jsonMap['due_datetime'] = due!['datetime'];
    }
    if (duration != null && duration!.isNotEmpty) {
      if (duration!['amount'] != null) {
        jsonMap['duration'] = duration!['amount'];
        if (duration!['unit'] != null) {
          jsonMap['duration_unit'] = duration!['unit'];
        }
      }
    }

    return jsonMap;
  }

  factory TaskModel.fromDomain(TaskEntity entity) {
    return TaskModel(
      // create/update
      projectId: entity.projectId,
      sectionId: entity.sectionId,
      content: entity.content,
      description: entity.description,
      labels: entity.labels,
      isCompleted: entity.isCompleted,
      order: entity.order,
      priority: entity.priority,
      due: {
        "datetime": entity.dueDateTime != null
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ")
                .format(entity.dueDateTime!)
            : null,
        "string": entity.dueString,
      },
      duration: {
        "amount": entity.durationAmount,
        "unit": entity.durationUnit,
      },
      id: entity.id,
      commentCount: entity.commentCount,
      url: entity.url,
      creatorId: entity.creatorId,
      createdAt: entity.createdAt?.toIso8601String(),
    );
  }

  TaskEntity toDomain() {
    return TaskEntity(
      // create/update
      projectId: projectId,
      sectionId: sectionId,
      content: content,
      description: description,
      labels: labels,
      // update
      isCompleted: isCompleted,
      order: order,
      priority: priority,
      dueString: due?["string"],
      dueDateTime: DateTime.tryParse(due?['datetime'] ?? ""),
      durationAmount: duration != null ? duration!['amount'] : null,
      durationUnit: duration != null ? duration!['unit'] : null,
      // read/delete
      id: id,
      creatorId: creatorId,
      createdAt: DateTime.tryParse(createdAt ?? ""),
      commentCount: commentCount,
      url: url,
    );
  }

  TaskModel copyWith({
    String? projectId,
    String? sectionId,
    String? content,
    String? description,
    List<String>? labels,
    bool? isCompleted,
    int? order,
    int? priority,
    Map<String, dynamic>? due,
    Map<String, dynamic>? duration,
    String? id,
    int? commentCount,
    String? url,
    String? creatorId,
    String? createdAt,
  }) {
    return TaskModel(
      projectId: projectId ?? this.projectId,
      sectionId: sectionId ?? this.sectionId,
      content: content ?? this.content,
      description: description ?? this.description,
      labels: labels ?? this.labels,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
      priority: priority ?? this.priority,
      due: due ?? this.due,
      duration: duration ?? this.duration,
      id: id ?? this.id,
      commentCount: commentCount ?? this.commentCount,
      url: url ?? this.url,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'TaskModel(projectId: $projectId, sectionId: $sectionId, content: $content, description: $description, labels: $labels, isCompleted: $isCompleted, order: $order, priority: $priority, due: $due, duration: $duration, id: $id, commentCount: $commentCount, url: $url, creatorId: $creatorId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.projectId == projectId &&
        other.sectionId == sectionId &&
        other.content == content &&
        other.description == description &&
        listEquals(other.labels, labels) &&
        other.isCompleted == isCompleted &&
        other.order == order &&
        other.priority == priority &&
        mapEquals(other.due, due) &&
        mapEquals(other.duration, duration) &&
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
        due.hashCode ^
        duration.hashCode ^
        id.hashCode ^
        commentCount.hashCode ^
        url.hashCode ^
        creatorId.hashCode ^
        createdAt.hashCode;
  }
}
